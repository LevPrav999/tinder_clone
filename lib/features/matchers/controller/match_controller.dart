import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/common/widgets/match_card.dart';
import 'package:tinder_clone/features/home/screens/home_screen.dart';
import 'package:tinder_clone/features/matchers/repositories/match_repository.dart';


final matchControllerProvider = StateNotifierProvider<MatchController, CardsState>((ref) {
  final matchRepository = ref.watch(matchRepositoryProvider);
  return MatchController(matchRepository: matchRepository);
});

class CardsState{
  final List<MatchCard> cards;
  final int index;

  CardsState({required this.cards, required this.index});

  CardsState copyWith({List<MatchCard>? cards, int? index}){
      return CardsState(cards: cards ?? this.cards, index: index ?? this.index);
  }
}

class MatchController extends StateNotifier<CardsState>{
  final MatchRepository matchRepository;

  MatchController({required this.matchRepository}) : super(CardsState(cards: [], index: 0));


  void setCards() async{
    var list = await matchRepository.getMatchers();

    state = state.copyWith(cards: list);
  }

  void setIndex(int index){
    state = state.copyWith(index: index);
  }

  void goBack(BuildContext context) async{
    Future.delayed(const Duration(seconds: 3)).then((value) => Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routeName, (route) => false));
  }

  void deletePending(String uidUser) async{
    matchRepository.deletePendingUser(uidUser);
  }


  void removeFromBlocked(String uidToRemove){
    matchRepository.removeFromBlocked(uidToRemove);
  }

  void addToPending(String uidUser) async{
    matchRepository.addToPending(uidUser);
  }
}