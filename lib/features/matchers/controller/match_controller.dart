import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/common/widgets/match_card.dart';
import 'package:tinder_clone/features/matchers/repositories/match_repository.dart';


final matchControllerProvider = StateNotifierProvider<MatchController, List<MatchCard>>((ref) {
  final matchRepository = ref.watch(matchRepositoryProvider);
  return MatchController(matchRepository: matchRepository);
});


class MatchController extends StateNotifier<List<MatchCard>>{
  final MatchRepository matchRepository;

  MatchController({required this.matchRepository}) : super([]);


  void setCards() async{
    var list = await matchRepository.getMatchers();

    state = list;
  }
}