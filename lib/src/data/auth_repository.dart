import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/errors/errors.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

final authStateChangeProvider = StreamProvider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChange;
});

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({
    required this.auth,
    required this.firestore,
  });

  Future<void> signInWithPhone(String phoneNumber) async {
    var completer = Completer<AuthCredential>();
    await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          completer.complete(credential);
        },
        verificationFailed: (e) {
          completer.completeError(e);
        },
        codeSent: (String verificationId, int? resendingToken) async {
          completer.completeError(
              NotAutomaticRetrieved(verificationId, "Code sent"));
        },
        codeAutoRetrievalTimeout: (String verificationId) {});

    var credential = await completer.future;
    await auth.signInWithCredential(credential);
  }

  Future<void> verifyCode(String verificationId, String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    await auth.signInWithCredential(credential);
  }

  Stream<User?> get authStateChange => auth.authStateChanges();

  String? get authUserUid => auth.currentUser?.uid;
}
