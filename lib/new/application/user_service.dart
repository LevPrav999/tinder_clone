import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/common/errors/errors.dart';
import 'package:tinder_clone/common/repositories/common_firebase_storage_repository.dart';
import 'package:tinder_clone/new/data/auth_repository.dart';
import 'package:tinder_clone/new/data/user_repository.dart';
import 'package:tinder_clone/new/presentaion/states/user_state.dart';
import '../../common/repositories/common_messaging_repository.dart';
import '../domain/user_model.dart';

final userServiceProvider = Provider<UserService>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return UserService(ref, userRepository);
});

class UserService {
  UserService(this.ref, this.userRepository);
  final Ref ref;
  final UserRepository userRepository;

  late StreamSubscription<DocumentSnapshot> subscription;

  Future<Either<Failture, bool>> saveUserData(
      String name,
      String age,
      String sex,
      String city,
      String bio,
      String sexFind,
      File? profilePicture,
      bool changeImage) async {
    try {
      String uid = ref.read(authRepositoryProvider).authUserUid!;

      UserModel? userFromDb = await userRepository.getUserInfo(uid);
      String photoUrl =
          await getUserAvatar(changeImage, profilePicture, userFromDb, uid);
      String? token = await MessagingApi().getToken();

      return Right(await userRepository.saveUserDataToFirebase(
          uid: uid,
          name: name,
          age: age,
          sex: sex,
          city: city,
          bio: bio,
          sexFind: sexFind,
          profilePicture: profilePicture,
          changeImage: changeImage,
          userFromDb: userFromDb,
          photoUrl: photoUrl,
          token: token));
    } catch (e) {
      return Left(FirestoreError("Error while add/update user."));
    }
  }

  Future<String> getUserAvatar(bool changeImage, File? profilePicture,
      UserModel? user, String uid) async {
    String photoUrl = "";

    if (changeImage == true) {
      if (profilePicture != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageRepositoryProvider)
            .storeFileToFirebase('profilePictures/$uid', profilePicture);
      }
    } else if (user != null) {
      photoUrl = user.avatar;
    } else {
      photoUrl =
          "https://www.pngall.com/wp-content/uploads/5/Profile-Avatar-PNG.png";

      if (profilePicture != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageRepositoryProvider)
            .storeFileToFirebase('profilePictures/$uid', profilePicture);
      }
    }
    return photoUrl;
  }

  Future<void> updateUserFcmToken(String uid, String? token) async {
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

  Future<Either<Failture, void>> setUserTags(List<dynamic> tags) async {
    try {
      if(tags.isEmpty){
        return Left(TagsUnselected("Select at least one preference."));
      }
      String uid = ref.read(authRepositoryProvider).authUserUid!;
      var result = await userRepository.setUserTags(tags, uid);
      return Right(result);
    } catch (e) {
      return Left(FirestoreError("Error while updating tags."));
    }
  }

  Future<void> getUserPresenceStatus(String uid) async {
    subscription = userRepository.getUserStatus(uid).listen((snapshot) {
      if (snapshot.exists) {
        UserModel user =
            UserModel.fromMap(snapshot.data()! as Map<String, dynamic>);
        bool isOnline = user.isOnline;

        bool? oldOnlineValue = ref.read(userStatusStateProvider.notifier).state;
        if (oldOnlineValue != isOnline) {
          ref
              .read(userStatusStateProvider.notifier)
              .update((state) => isOnline);
        }
      }
    });
  }

  void stopListeningToUserOnlineStatus() {
    subscription.cancel();
  }

  Future<bool> isUserExists(String uid) async {
    return await userRepository.isUserExists(uid);
  }
}
