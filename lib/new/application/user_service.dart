import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/new/data/auth_repository.dart';
import 'package:tinder_clone/new/data/user_repository.dart';
import '../../common/repositories/common_messaging_repository.dart';
import '../domain/user_model.dart';


final userServiceProvider = Provider<UserService>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return UserService(ref, userRepository);
});

class UserService{
  UserService(this.ref, this.userRepository);
  final Ref ref;
  final UserRepository userRepository;

  Future<void> saveUserData(
    {required String name,
      required String age,
      required String sex,
      required String city,
      required String bio,
      required String sexFind,
      required File? profilePicture,
      required bool changeImage,
      required ProviderRef ref,
      required BuildContext context}
  ) async{
      String uid = ref.read(authRepositoryProvider).authUserUid!;

      UserModel? userFromDb = await userRepository.getUserInfo(uid);
      String photoUrl = await userRepository.getUserAvatar(changeImage, profilePicture, userFromDb, uid);
      String? token = await MessagingApi().getToken();

      await userRepository.saveUserDataToFirebase(uid: uid, name: name, age: age, sex: sex, city: city, bio: bio, sexFind: sexFind, profilePicture: profilePicture, changeImage: changeImage, ref: ref, context: context, userFromDb: userFromDb, photoUrl: photoUrl, token: token);
  }

  Future<void> updateUserFcmToken(String uid, String? token) async{
    await userRepository.updateUserFcmToken(uid, token);
  }

  Stream<UserModel?> getUserData(String uid) {
    return userRepository.getUserData(uid);
  }

  Future<UserModel?> getUserInfo(String? uid) async {
    String? id = uid ?? ref.read(authRepositoryProvider).authUserUid;
    return userRepository.getUserInfo(id);
  }

  Future<void> setUserStatus(bool isOnline) async {
    String uid = ref.read(authRepositoryProvider).authUserUid!;
    await userRepository.setUserStatus(isOnline, uid);
  }

  Future<void> setUserTags(List<dynamic> tags, BuildContext context) async {
    String uid = ref.read(authRepositoryProvider).authUserUid!;
    await userRepository.setUserTags(tags, context, uid);

    Navigator.pushNamedAndRemoveUntil(
        context, HomeScreen.routeName, (route) => false);
  }

  Future<void> getUserPresenceStatus(String uid) async {
    await userRepository.getUserPresenceStatus(uid);
  }

  void stopListeningToUserOnlineStatus() {
    userRepository.stopListeningToUserOnlineStatus();
  }

  Future<bool> isUserExists(String uid) async{
    return await userRepository.isUserExists(uid);
  }

}