import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tinder_clone/common/models/user_model.dart';
import 'package:tinder_clone/common/utils/utils.dart';
import 'package:tinder_clone/common/widgets/match_card.dart';

class MatchRepository{
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  MatchRepository({required this.auth, required this.firestore});


  Future<List<MatchCard>> getMatchers() async{
    String uid = auth.currentUser!.uid;
    List<MatchCard> matchCards = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();

    for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
      UserModel data = UserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);

      if (data.liked.contains(uid)) {
        String age = getAge(data.age['year']);

        MatchCard matchCard = MatchCard(
          uid: documentSnapshot.id,
          name: data.name,
          imageURL: data.avatar,
          age: age,
          bio: data.bio,
        );

        matchCards.add(matchCard);
      }
    }

    return matchCards;
  }
}