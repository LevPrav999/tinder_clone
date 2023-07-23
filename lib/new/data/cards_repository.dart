import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/utils/utils.dart';
import '../../common/widgets/match_card.dart';
import '../domain/user_model.dart';

final cardsRepositoryProvider = Provider((ref) => CardsRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class CardsRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  CardsRepository({required this.auth, required this.firestore});

  Future<List<MatchCard>> getCards(String uid, UserModel? user) async {

    final minBirthDate =
        DateTime(user!.age['year'] - 1, user.age['month'], user.age['day']);
    final maxBirthDate =
        DateTime(user.age['year'] + 1, user.age['month'], user.age['day']);

    CollectionReference usersRef = firestore.collection('users');
    Query query = usersRef
        .where('city', isEqualTo: user.city)
        .where('sex', isEqualTo: user.sexFind)
        .where('sexFind', isEqualTo: user.sex)
        .where('age.year', isGreaterThanOrEqualTo: minBirthDate.year)
        .where('age.year', isLessThanOrEqualTo: maxBirthDate.year);

    List<List<String>> subsets = splitListIntoSubsets(user.tags, 10);

    List<Future<QuerySnapshot>> queryFutures = [];

    for (List<String> subset in subsets) {
      Query subsetQuery = query.where('tags', arrayContainsAny: subset);
      queryFutures.add(subsetQuery.get());
    }

    List<QuerySnapshot> querySnapshots = await Future.wait(queryFutures);

    List<MatchCard> randomDocuments = [];

    for (QuerySnapshot querySnapshot in querySnapshots) {
      List<QueryDocumentSnapshot> documents = querySnapshot.docs;
      documents.removeWhere((doc) => doc.id == uid);

      final random = Random();

      for (var i = 0; i < 10; i++) {
        if (documents.isEmpty) break;
        final randomIndex = random.nextInt(documents.length);
        final document = documents[randomIndex];
        if (user.liked.contains(document.id) ||
            user.blocked.contains(document.id) ||
            user.pending.contains(document.id)) {
          documents.removeAt(randomIndex);
          continue;
        }
        final matchCard = MatchCard(
          user: UserModel.fromMap(document.data() as Map<String, dynamic>),
        );
        randomDocuments.add(matchCard);
        documents.removeAt(randomIndex);
      }
    }

    return randomDocuments;
  }

  Future<void> addToLiked(String uid, String uidToAdd) async {
    await firestore.collection('users').doc(uid).update({
      'liked': FieldValue.arrayUnion([uidToAdd])
    });

    await firestore.collection('users').doc(uidToAdd).update({
      'pending': FieldValue.arrayUnion([uid])
    });
  }

  Future<void> addToBlocked(String uid, String uidToAdd) async {
    await firestore.collection('users').doc(uid).update({
      'blocked': FieldValue.arrayUnion([uidToAdd])
    });
  }

  Future<void> removeFromLiked(String uid, String uidToRemove) async {
    await firestore.collection('users').doc(uid).update({
        'liked': FieldValue.arrayRemove([uidToRemove])
      });

    await firestore.collection('users').doc(uidToRemove).update({
      'pending': FieldValue.arrayUnion([uid])
    });
  }

  Future<void> removeFromBlocked(String uid, String uidToRemove) async {
    await firestore.collection('users').doc(uid).update({
        'blocked': FieldValue.arrayRemove([uidToRemove])
      });
  }
}
