import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/common/models/user_model.dart';
import 'package:tinder_clone/features/home/repositories/user_repository.dart';

final userControllerProvider = Provider((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return UserController(userRepository: userRepository);
});

final userStateProvider = StateProvider<UserModel?>((ref) => null);


class UserController{
  final UserRepository userRepository;

  UserController({required this.userRepository});


}
