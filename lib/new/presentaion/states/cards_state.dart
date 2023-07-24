import '../../../common/widgets/match_card.dart';

class CardsState{
  final List<MatchCard> cards;
  final int index;

  CardsState({required this.cards, required this.index});

  CardsState copyWith({List<MatchCard>? cards, int? index}){
      return CardsState(cards: cards ?? this.cards, index: index ?? this.index);
  }
}