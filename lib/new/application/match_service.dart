import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/new/data/auth_repository.dart';
import 'package:tinder_clone/new/data/match_repository.dart';
import 'package:tinder_clone/new/data/user_repository.dart';

import '../../common/widgets/match_card.dart';
import '../domain/user_model.dart';

final matchServiceProvider = Provider<MatchService>((ref) {
  final matchRepository = ref.watch(matchRepositoryProvider);
  return MatchService(ref, matchRepository);
});

class MatchService {
  MatchService(this.ref, this.matchRepository);
  final Ref ref;
  final MatchRepository matchRepository;

  Future<List<MatchCard>> getMatchers() async {
    String uid = ref.read(authRepositoryProvider).authUserUid!;
    UserModel? user = await ref.read(userRepositoryProvider).getUserInfo(uid);

    return await matchRepository.getMatchers(uid, user);
  }

  Future<void> deletePendingUserAndBlock(String uidUser) async {
    String uid = ref.read(authRepositoryProvider).authUserUid!;
    matchRepository.deletePendingUserAndBlock(uid, uidUser);
  }

  Future<void> deletePendingUserAndLike(String uidUser) async {
    String uid = ref.read(authRepositoryProvider).authUserUid!;
    matchRepository.deletePendingUserAndLike(uid, uidUser);
  }

  Future<void> removeFromBlocked(String uidToRemove) async {
    String uid = ref.read(authRepositoryProvider).authUserUid!;
    matchRepository.removeFromBlocked(uid, uidToRemove);
  }

  Future<void> addToPending(String uidToAdd) async {
    String uid = ref.read(authRepositoryProvider).authUserUid!;
    matchRepository.addToPending(uid, uidToAdd);
  }
}
