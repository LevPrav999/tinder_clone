import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/new/data/auth_repository.dart';
import 'package:tinder_clone/new/data/cards_repository.dart';
import 'package:tinder_clone/new/data/user_repository.dart';

import '../../common/widgets/match_card.dart';
import '../domain/user_model.dart';

final cardsServiceProvider = Provider<CardsService>((ref) {
  final cardsRepository = ref.watch(cardsRepositoryProvider);
  return CardsService(ref, cardsRepository);
});

class CardsService {
  CardsService(this.ref, this.cardsRepository);
  final Ref ref;
  final CardsRepository cardsRepository;

  Future<List<MatchCard>> getCards() async {
    String uid = ref.read(authRepositoryProvider).authUserUid!;
    UserModel? user = await ref.read(userRepositoryProvider).getUserInfo(uid);

    return cardsRepository.getCards(uid, user);
  }

  Future<void> addToLiked(String uidToAdd) async {
    String uid = ref.read(authRepositoryProvider).authUserUid!;

    await cardsRepository.addToLiked(uid, uidToAdd);
  }

  Future<void> addToBlocked(String uidToAdd) async {
    String uid = ref.read(authRepositoryProvider).authUserUid!;

    await cardsRepository.addToBlocked(uid, uidToAdd);
  }

  Future<void> removeFromLiked(String uidToRemove) async {
    String uid = ref.read(authRepositoryProvider).authUserUid!;
    await cardsRepository.removeFromLiked(uid, uidToRemove);
  }

  Future<void> removeFromBlocked(String uidToRemove) async {
    String uid = ref.read(authRepositoryProvider).authUserUid!;
    await cardsRepository.removeFromBlocked(uid, uidToRemove);
  }
}
