import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/common/repositories/common_firebase_storage_repository.dart';
import '../../common/utils/utils.dart';
import '../domain/user_model.dart';

final userRepositoryProvider = Provider((ref) => UserRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance, ref: ref));


class UserRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final Ref ref;

  late StreamSubscription<DocumentSnapshot> subscription;

  UserRepository({required this.auth, required this.firestore, required this.ref});

  Future<bool> saveUserDataToFirebase(
      {
      required String uid,  
      required String name,
      required String age,
      required String sex,
      required String city,
      required String bio,
      required String sexFind,
      required File? profilePicture,
      required bool changeImage,
      required UserModel? userFromDb,
      required String photoUrl,
      required String? token
      }) async {
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
          blocked: userFromDb != null ? userFromDb.blocked : [],
          liked: userFromDb != null ? userFromDb.liked : [],
          pending: userFromDb != null ? userFromDb.pending : [],
          tags: userFromDb != null ? userFromDb.tags : [],
          isPrime: userFromDb != null ? userFromDb.isPrime : false,
          fcmToken: userFromDb != null ? userFromDb.fcmToken : token ?? "");

      if (userFromDb != null) {

        await firestore.collection('users').doc(uid).update(user.toMap());
        await _updateUserDataInSubCollections(
            uid, user.fcmToken, user.avatar, user.name);
        return true;

      } else {

        await firestore.collection('users').doc(uid).set(user.toMap());
        return false;
            
      }
  }

  Future<String> getUserAvatar(bool changeImage, File? profilePicture, UserModel? user, String uid) async{
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

  Future<void> updateUserFcmToken(String uid, String? token) async{
      await firestore
            .collection('users')
            .doc(uid)
            .update({"fcmToken": token ?? ""});
        await _updateUserDataInSubCollections(uid, token ?? "", null, null);
  }

  Future<void> _updateUserDataInSubCollections(
      String uid, String fcmToken, String? profilePic, String? name) async {
    final usersList =
        await FirebaseFirestore.instance.collection('users').get();
    for (var user in usersList.docs) {
      final chatsList = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.id)
          .collection('chats')
          .get();
      if (chatsList.docs.isEmpty) {
        continue;
      } else {
        final chatsList = FirebaseFirestore.instance
            .collection('users')
            .doc(user.id)
            .collection('chats');
        final userDoc = await chatsList.doc(uid).get();
        if (userDoc.exists) {
          if (profilePic == null && name == null) {
            await chatsList.doc(uid).update({
              'fcmToken': fcmToken,
            });
          } else {
            await chatsList.doc(uid).update(
                {'fcmToken': fcmToken, 'profilePic': profilePic, 'name': name});
          }
        }
      }
    }
  }

  Stream<UserModel?> getUserData(String uid) {
    return firestore.collection('users').doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }

  Future<UserModel?> getUserInfo(String? id) async {
    UserModel? user;
    final userInfo =
        await firestore.collection('users').doc(id).get();

    if (userInfo.data() == null) return user;
    user = UserModel.fromMap(userInfo.data()!);
    return user;
  }

  Future<void> setUserStatus(bool isOnline, String uid) async {
    await firestore
        .collection('users')
        .doc(uid)
        .update({'isOnline': isOnline});
  }

  Future<void> setUserTags(List<dynamic> tags, String uid) async {
    await firestore
        .collection('users')
        .doc(uid)
        .update({'tags': tags});
  }

  Stream<DocumentSnapshot> getUserStatus(String uid){
    return firestore.collection('users').doc(uid).snapshots();
  }

  Future<bool> isUserExists(String uid) async{
    DocumentSnapshot userSnap =
          await firestore.collection('users').doc(uid).get();
    return userSnap.exists;
  }
}
