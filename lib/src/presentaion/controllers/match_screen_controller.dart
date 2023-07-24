import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/src/application/match_service.dart';

import '../states/cards_state.dart';



final matchProvider = AsyncNotifierProvider<MatchNotifier, CardsState>(MatchNotifier.new);

class MatchNotifier extends AsyncNotifier<CardsState> {
  @override
  FutureOr<CardsState> build() {
    return CardsState(cards: [], index: 0);
  }

  void setCards() async{
    var list = await ref.read(matchServiceProvider).getMatchers();

    state = AsyncValue.data(state.value!.copyWith(cards: list));
  }

  void setIndex(int index){
    state = AsyncValue.data(state.value!.copyWith(index: index));
  }

  void deletePendingAndBlock(String uidUser) async{
    ref.read(matchServiceProvider).deletePendingUserAndBlock(uidUser);
  }

  void deletePendingAndLike(String uidUser) async{
    ref.read(matchServiceProvider).deletePendingUserAndLike(uidUser);
  }


  void removeFromBlocked(String uidToRemove){
    ref.read(matchServiceProvider).removeFromBlocked(uidToRemove);
  }

  void addToPending(String uidUser) async{
    ref.read(matchServiceProvider).addToPending(uidUser);
  }
}