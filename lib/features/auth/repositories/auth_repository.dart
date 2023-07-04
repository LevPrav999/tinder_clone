import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/common/helper/show_alert_dialog.dart';
import 'package:tinder_clone/common/models/user_model.dart';
import 'package:tinder_clone/common/repositories/common_firebase_storage_repository.dart';
import 'package:tinder_clone/common/utils/utils.dart';
import 'package:tinder_clone/features/auth/screens/code_screen.dart';
import 'package:tinder_clone/features/auth/screens/user_information_screen.dart';
import 'package:tinder_clone/features/home/screens/home_screen.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({
    required this.auth,
    required this.firestore,
  });

  void signInWithPhone(BuildContext context, String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (e) {
            throw Exception(e.message);
          },
          codeSent: (String verificationId, int? resendingToken) async {
            Navigator.pushNamed(context, CodeScreen.routeName,
                arguments: verificationId);
          },
          codeAutoRetrievalTimeout: (String verificationId) {});
    } on FirebaseAuthException catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  void verifyCode(
      {required BuildContext context,
      required String verificationId,
      required String smsCode}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      await auth.signInWithCredential(credential);

      Navigator.pushNamedAndRemoveUntil(
          context, UserInfoScreen.routeName, (route) => false);
    } on FirebaseAuthException catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  void saveUserDataToFirebase(
      {required String name,
      required String age,
      required String sex,
      required String city,
      required String bio,
      required String sexFind,
      required File? profilePicture,
      required ProviderRef ref,
      required BuildContext context}) async {
    try {
      String uid = auth.currentUser!.uid;
      String photoUrl =
          "https://www.pngall.com/wp-content/uploads/5/Profile-Avatar-PNG.png";

      if (profilePicture != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageRepositoryProvider)
            .storeFileToFirebase('profilePictures/$uid', profilePicture);
      }

      var user = UserModel(uid: uid, name: name, avatar: photoUrl, age: convertBirthday(age), sex: sex, city: city, bio: bio, sexFind: sexFind, isOnline: true, blocked: [], liked: [], pending: []);

      await firestore.collection('users').doc(uid).set(user.toMap());
      
      Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false);
    } catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }
}
