import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final matchRepositoryProvider = Provider((ref) => MatchRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class MatchRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  MatchRepository({required this.auth, required this.firestore});


  Future<void> deletePendingUserAndBlock(String uid, String uidUser) async{
    await firestore.collection('users').doc(uid).update({
      'pending': FieldValue.arrayRemove([uidUser])
    });

    await firestore.collection('users').doc(uid).update({
      'blocked': FieldValue.arrayUnion([uidUser])
    });
  }

  Future<void> deletePendingUserAndLike(String uid, String uidUser) async{
    await firestore.collection('users').doc(uid).update({
      'pending': FieldValue.arrayRemove([uidUser])
    });

    await firestore.collection('users').doc(uid).update({
      'liked': FieldValue.arrayUnion([uidUser])
    });
  }

  Future<void> removeFromBlocked(String uid, String uidToRemove) async {
     await firestore.collection('users').doc(uid).update({
        'blocked': FieldValue.arrayRemove([uidToRemove])
      });
  }

  Future<void> addToPending(String uid, String uidToAdd) async {
    await firestore.collection('users').doc(uid).update({
        'pending': FieldValue.arrayUnion([uidToAdd])
      });
  }
}
