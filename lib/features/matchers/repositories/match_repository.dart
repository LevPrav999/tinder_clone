import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/common/models/user_model.dart';
import 'package:tinder_clone/common/widgets/match_card.dart';

final matchRepositoryProvider = Provider((ref) => MatchRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class MatchRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  MatchRepository({required this.auth, required this.firestore});

  Future<List<MatchCard>> getMatchers() async {
    String uid = auth.currentUser!.uid;
    List<MatchCard> pendingMatches = [];

    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    List<dynamic> pendingData = userSnapshot.get('pending');

    for (String pendingUserId in pendingData) {
      DocumentSnapshot pendingUserSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(pendingUserId)
          .get();
      var data =
          UserModel.fromMap(pendingUserSnapshot.data() as Map<String, dynamic>);

      MatchCard matchCard = MatchCard(user: data);
      pendingMatches.add(matchCard);
    }

    return pendingMatches;
  }

  void deletePendingUserAndBlock(String uidUser) async{
    String uid = auth.currentUser!.uid;
    await firestore.collection('users').doc(uid).update({
      'pending': FieldValue.arrayRemove([uidUser])
    });

    await firestore.collection('users').doc(uid).update({
      'blocked': FieldValue.arrayUnion([uidUser])
    });
  }

  void deletePendingUserAndLike(String uidUser) async{
    String uid = auth.currentUser!.uid;
    await firestore.collection('users').doc(uid).update({
      'pending': FieldValue.arrayRemove([uidUser])
    });

    await firestore.collection('users').doc(uid).update({
      'liked': FieldValue.arrayUnion([uidUser])
    });
  }

  void removeFromBlocked(String uidToRemove) async {
    String uid = auth.currentUser!.uid;

     await firestore.collection('users').doc(uid).update({
        'blocked': FieldValue.arrayRemove([uidToRemove])
      });
  }

  void addToPending(String uidToAdd) async {
    String uid = auth.currentUser!.uid;

    await firestore.collection('users').doc(uid).update({
        'pending': FieldValue.arrayUnion([uidToAdd])
      });
  }
}
