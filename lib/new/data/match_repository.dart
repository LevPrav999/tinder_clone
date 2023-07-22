import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/new/data/auth_repository.dart';
import 'package:tinder_clone/new/data/user_repository.dart';

import '../../common/widgets/match_card.dart';
import '../domain/user_model.dart';

final matchRepositoryProvider = Provider((ref) => MatchRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance, ref: ref));

class MatchRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final Ref ref;

  MatchRepository({required this.auth, required this.firestore, required this.ref});

  Future<List<MatchCard>> getMatchers(String uid, UserModel? user) async {
    List<MatchCard> pendingMatches = [];

    List<dynamic> pendingData = user!.pending;

    for (String pendingUserId in pendingData) {
      UserModel? data =
          await ref.read(userRepositoryProvider).getUserInfo(pendingUserId);

      MatchCard matchCard = MatchCard(user: data!);
      pendingMatches.add(matchCard);
    }

    return pendingMatches;
  }

  Future<void> deletePendingUserAndBlock(String uid, String uidUser) async{
     String uid = ref.read(authRepositoryProvider).authUserUid!;
    await firestore.collection('users').doc(uid).update({
      'pending': FieldValue.arrayRemove([uidUser])
    });

    await firestore.collection('users').doc(uid).update({
      'blocked': FieldValue.arrayUnion([uidUser])
    });
  }

  Future<void> deletePendingUserAndLike(String uid, String uidUser) async{
     String uid = ref.read(authRepositoryProvider).authUserUid!;
    await firestore.collection('users').doc(uid).update({
      'pending': FieldValue.arrayRemove([uidUser])
    });

    await firestore.collection('users').doc(uid).update({
      'liked': FieldValue.arrayUnion([uidUser])
    });
  }

  Future<void> removeFromBlocked(String uid, String uidToRemove) async {
     String uid = ref.read(authRepositoryProvider).authUserUid!;

     await firestore.collection('users').doc(uid).update({
        'blocked': FieldValue.arrayRemove([uidToRemove])
      });
  }

  Future<void> addToPending(String uid, String uidToAdd) async {
     String uid = ref.read(authRepositoryProvider).authUserUid!;

    await firestore.collection('users').doc(uid).update({
        'pending': FieldValue.arrayUnion([uidToAdd])
      });
  }
}
