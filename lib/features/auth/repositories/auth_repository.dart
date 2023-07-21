import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/common/helper/show_alert_dialog.dart';
import 'package:tinder_clone/common/models/user_model.dart';
import 'package:tinder_clone/common/repositories/common_firebase_storage_repository.dart';
import 'package:tinder_clone/common/repositories/common_messaging_repository.dart';
import 'package:tinder_clone/common/utils/utils.dart';
import 'package:tinder_clone/features/auth/controller/auth_controller.dart';
import 'package:tinder_clone/features/auth/screens/code_screen.dart';
import 'package:tinder_clone/features/auth/screens/tags_screen.dart';
import 'package:tinder_clone/features/auth/screens/user_information_screen.dart';
import 'package:tinder_clone/features/home/screens/home_screen.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  late StreamSubscription<DocumentSnapshot> subscription;

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

      String uid = auth.currentUser!.uid;
      DocumentSnapshot userSnap =
          await firestore.collection('users').doc(uid).get();

      if (userSnap.exists) {
        String? token = await MessagingApi().getToken();
        await firestore
            .collection('users')
            .doc(uid)
            .update({"fcmToken": token ?? ""});
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context,
            UserInfoScreen.routeName,
            arguments: {'fromProfile': false},
            (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  Stream<User?> get authStateChange => auth.authStateChanges();

  void saveUserDataToFirebase(
      {required String name,
      required String age,
      required String sex,
      required String city,
      required String bio,
      required String sexFind,
      required File? profilePicture,
      required bool changeImage,
      required ProviderRef ref,
      required BuildContext context}) async {
    try {
      String uid = auth.currentUser!.uid;
      DocumentSnapshot userSnap =
          await firestore.collection('users').doc(uid).get();

      String photoUrl = "";

      if (changeImage == true) {
        if (profilePicture != null) {
          photoUrl = await ref
              .read(commonFirebaseStorageRepositoryProvider)
              .storeFileToFirebase('profilePictures/$uid', profilePicture);
        }
      } else if (userSnap.exists) {
        var data = userSnap.data() as Map<String, dynamic>;
        photoUrl = data['avatar'];
      } else {
        photoUrl =
            "https://www.pngall.com/wp-content/uploads/5/Profile-Avatar-PNG.png";

        if (profilePicture != null) {
          photoUrl = await ref
              .read(commonFirebaseStorageRepositoryProvider)
              .storeFileToFirebase('profilePictures/$uid', profilePicture);
        }
      }
      late UserModel userFromDb;
      if (userSnap.exists)
        userFromDb = UserModel.fromMap(userSnap.data() as Map<String, dynamic>);

      String? token = await MessagingApi().getToken();

      var user = UserModel(
          uid: uid,
          name: name,
          avatar: photoUrl,
          age: convertBirthday(age),
          sex: sex,
          city: city,
          bio: bio,
          sexFind: sexFind,
          isOnline: true,
          blocked: userSnap.exists ? userFromDb.blocked : [],
          liked: userSnap.exists ? userFromDb.liked : [],
          pending: userSnap.exists ? userFromDb.pending : [],
          tags: userSnap.exists ? userFromDb.tags : [],
          isPrime: userSnap.exists ? userFromDb.isPrime : false,
          fcmToken: userSnap.exists ? userFromDb.fcmToken : token ?? "");

      if (userSnap.exists) {
        await firestore.collection('users').doc(uid).update(user.toMap());
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (route) => false);
      } else {
        await firestore.collection('users').doc(uid).set(user.toMap());
        Navigator.pushNamedAndRemoveUntil(
            context, TagsScreen.routeName, (route) => false,
            arguments: []);
      }
    } catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  Stream<UserModel?> getUserData(String uid) {
    return firestore.collection('users').doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }

  Future<UserModel?> getCurrentUserInfo() async {
    UserModel? user;
    final userInfo =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();

    if (userInfo.data() == null) return user;
    user = UserModel.fromMap(userInfo.data()!);
    return user;
  }

  void setUserStatus(bool isOnline) async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({'isOnline': isOnline});
  }

  void setUserTags(List<dynamic> tags, BuildContext context) async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({'tags': tags});

    Navigator.pushNamedAndRemoveUntil(
        context, HomeScreen.routeName, (route) => false);
  }

  void getUserPresenceStatus(
      {required String uid, required WidgetRef ref}) async {
    subscription =
        firestore.collection('users').doc(uid).snapshots().listen((snapshot) {
      if (snapshot.exists) {
        bool isOnline = snapshot.data()?['isOnline'] ?? false;
        print('User is online: $isOnline');
        ref.read(userStatusStateProvider.notifier).update((state) => isOnline);
      } else {
        print('Document does not exist');
      }
    });
  }

  void stopListeningToUserOnlineStatus() {
    subscription.cancel();
  }
}
