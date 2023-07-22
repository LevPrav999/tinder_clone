import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/helper/show_alert_dialog.dart';
import '../presentaion/screens/code_screen.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({
    required this.auth,
    required this.firestore,
  });

  Future<void> signInWithPhone(BuildContext context, String phoneNumber) async {
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

  Future<void> verifyCode(BuildContext context, String verificationId, String smsCode) async {
    try {

      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      await auth.signInWithCredential(credential);

    } on FirebaseAuthException catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  Stream<User?> get authStateChange => auth.authStateChanges();

  String? get authUserUid => auth.currentUser?.uid;

}
