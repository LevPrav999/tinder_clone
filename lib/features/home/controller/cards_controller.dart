import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/common/states/cards_state.dart';
import 'package:tinder_clone/features/home/repositories/cards_repository.dart';

final cardsControllerProvider = StateNotifierProvider<CardsController, CardsState>((ref) {
  final cardsRepository = ref.watch(cardsRepositoryProvider);
  return CardsController(cardsRepository: cardsRepository);
});


class CardsController extends StateNotifier<CardsState>{
  final CardsRepository cardsRepository;

  CardsController({required this.cardsRepository}) : super(CardsState(cards: [], index: 0));

  void setCards() async{
    var list = await cardsRepository.getCards();

    state = state.copyWith(cards: list);
  }

  void setIndex(int index){
    state = state.copyWith(index: index);
  }


  void addToLiked(String uidToAdd){
    cardsRepository.addToLiked(uidToAdd);
  }

  void addToBlocked(String uidToAdd){
    cardsRepository.addToBlocked(uidToAdd);
  }

  void removeFromLiked(String uidToRemove){
    cardsRepository.removeFromLiked(uidToRemove);
  }

  void removeFromBlocked(String uidToRemove){
    cardsRepository.removeFromBlocked(uidToRemove);
  }
}