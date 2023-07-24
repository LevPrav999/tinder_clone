import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/new/application/cards_service.dart';

import '../../states/cards_state.dart';


final cardsTabProvider = AsyncNotifierProvider<CardsTabNotifier, CardsState>(CardsTabNotifier.new);

class CardsTabNotifier extends AsyncNotifier<CardsState> {
  @override
  FutureOr<CardsState> build() {
    return CardsState(cards: [], index: 0);
  }

  void setCards() async{
    var list = await ref.read(cardsServiceProvider).getCards();

    state = AsyncValue.data(state.value!.copyWith(cards: list));
  }

  void setIndex(int index){
    state = AsyncValue.data(state.value!.copyWith(index: index));
  }


  void addToLiked(String uidToAdd){
    ref.read(cardsServiceProvider).addToLiked(uidToAdd);
  }

  void addToBlocked(String uidToAdd){
    ref.read(cardsServiceProvider).addToBlocked(uidToAdd);
  }

  void removeFromLiked(String uidToRemove){
    ref.read(cardsServiceProvider).removeFromLiked(uidToRemove);
  }

  void removeFromBlocked(String uidToRemove){
    ref.read(cardsServiceProvider).removeFromBlocked(uidToRemove);
  }
}