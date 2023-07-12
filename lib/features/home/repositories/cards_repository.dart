import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/common/models/user_model.dart';
import 'package:tinder_clone/common/widgets/match_card.dart';

final cardsRepositoryProvider = Provider((ref) => CardsRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));


class CardsRepository{
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  CardsRepository({required this.auth, required this.firestore});


  Future<List<MatchCard>> getCards() async{
    String uid = auth.currentUser!.uid;
    var userData = await firestore.collection('users').doc(uid).get();
    UserModel user = UserModel.fromMap(userData.data()!);

    final minBirthDate = DateTime(
        user.age['year'] - 1, user.age['month'], user.age['day']);
    final maxBirthDate = DateTime(
        user.age['year'] + 1, user.age['month'], user.age['day']);

    final querySnapshot = await firestore
        .collection('users')
        .where('city', isEqualTo: user.city)
        .where('sex', isEqualTo: user.sexFind)
        .where('sexFind', isEqualTo: user.sex)
        .where('age.year', isGreaterThanOrEqualTo: minBirthDate.year)
        .where('age.year', isLessThanOrEqualTo: maxBirthDate.year)
        .get();

    final random = Random();
    final documents = querySnapshot.docs;
    final randomDocuments = <MatchCard>[];

    documents.removeWhere((doc) => doc.id == uid);

    for (var i = 0; i < 10; i++) {
      if (documents.isEmpty) break;
      final randomIndex = random.nextInt(documents.length);
      final document = documents[randomIndex];
      if (user.liked.contains(document.id) ||
          user.blocked.contains(document.id) || user.pending.contains(document.id)) {
        documents.removeAt(randomIndex);
        continue;
      }
      final matchCard = MatchCard(
        user: UserModel.fromMap(document.data())
      );
      randomDocuments.add(matchCard);
      documents.removeAt(randomIndex);
    }

    return randomDocuments;
  }

  void addToLiked(String uidToAdd) async {
    String uid = auth.currentUser!.uid;
    await firestore.collection('users').doc(uid).update({
      'liked': FieldValue.arrayUnion([uidToAdd])
    });

    await firestore.collection('users').doc(uidToAdd).update({
      'pending': FieldValue.arrayUnion([uid])
    });
  }

  void addToBlocked(String uidToAdd) async {
    String uid = auth.currentUser!.uid;
    await firestore.collection('users').doc(uid).update({
      'blocked': FieldValue.arrayUnion([uidToAdd])
    });
  }

  void removeFromLiked(String uidToRemove) async {
    String uid = auth.currentUser!.uid;
    var user = await firestore.collection('users').doc(uid).get();
    if(UserModel.fromMap(user.data()!).liked.contains(uidToRemove)){
      await firestore.collection('users').doc(uid).update({
      'liked': FieldValue.arrayRemove([uidToRemove])
    });
    }

    await firestore.collection('users').doc(uidToRemove).update({
      'pending': FieldValue.arrayUnion([uid])
    });
  }

  void removeFromBlocked(String uidToRemove) async {
    String uid = auth.currentUser!.uid;
    var user = await firestore.collection('users').doc(uid).get();
    if(UserModel.fromMap(user.data()!).blocked.contains(uidToRemove)){
      await firestore.collection('users').doc(uid).update({
        'blocked': FieldValue.arrayRemove([uidToRemove])
      });
    }
  }


}