import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/common/models/user_model.dart';
import 'package:tinder_clone/features/auth/repositories/auth_repository.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(ref: ref, authRepository: authRepository);
});


final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.authStateChange;
});

final userInfoAuthProvider = FutureProvider(
  (ref) {
    final authController = ref.watch(authControllerProvider);
    return authController.getCurrentUserInfo();
  },
);




class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;
  AuthController({ required this.ref, required this.authRepository});

  void signInWithPhone(BuildContext context, String phoneNumber) {
    authRepository.signInWithPhone(context, phoneNumber);
  }

  void vetifyOTP(BuildContext context, String verificationId, String userCode) {
    authRepository.verifyCode(
        context: context, verificationId: verificationId, smsCode: userCode);
  }

  void saveDataToFirestore(
      String name,
      String age,
      String sex,
      String city,
      String bio,
      String sexFind,
      File? profilePicture,
      bool changeImage,
      BuildContext context) {

    authRepository.saveUserDataToFirebase(
        name: name,
        age: age,
        sex: sex,
        city: city,
        bio: bio,
        sexFind: sexFind,
        profilePicture: profilePicture,
        changeImage: changeImage,
        ref: ref,
        context: context);
  }

  Stream<User?> get authStateChange => authRepository.authStateChange;

  Stream<UserModel?> getUserData(String uid){
    return authRepository.getUserData(uid);
  }

  Future<UserModel?> getCurrentUserInfo() async {
    UserModel? user = await authRepository.getCurrentUserInfo();
    return user;
  }

  void setUserStatus(bool isOnline){
    authRepository.setUserStatus(isOnline);
  }


  Stream<UserModel> getUserPresenceStatus({required String uid}) {
    return authRepository.getUserPresenceStatus(uid: uid);
  }

  void setUserTags(List<dynamic> tags, BuildContext context){
    return authRepository.setUserTags(tags, context);
  }
}
