import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/common/models/user_model.dart';

final userRepositoryProvider = Provider((ref) => UserRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));


class UserRepository{
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  UserRepository({
    required this.auth,
    required this.firestore,
  });

  Future<UserModel> getUserDataFromFirestore() async{
    var document = await firestore.collection('users').doc(auth.currentUser!.uid).get();

    UserModel.fromMap(document.data()!);
    UserModel user = UserModel.fromMap(document.data()!);

    return user;
  }
}