import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/common/widgets/match_card.dart';
import 'package:tinder_clone/features/home/repositories/cards_repository.dart';

final cardsControllerProvider = StateNotifierProvider<CardsController, List<MatchCard>>((ref) {
  final cardsRepository = ref.watch(cardsRepositoryProvider);
  return CardsController(cardsRepository: cardsRepository);
});


class CardsController extends StateNotifier<List<MatchCard>>{
  final CardsRepository cardsRepository;

  CardsController({required this.cardsRepository}) : super([]);

  void setState() async{
    var data = await cardsRepository.getCards();
    state = data;
  }

  void addToLiked(String uidToAdd){
    cardsRepository.addToLiked(uidToAdd);
  }

  void addToBlocked(String uidToAdd){
    cardsRepository.addToBlocked(uidToAdd);
  }
}