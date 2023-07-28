

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/user_model.dart';

final userStateProvider = StateProvider<UserModel?>((ref) => null);

final userStatusStateProvider = StateProvider<bool?>((ref) => null);

final connectionStateProvider = StateProvider<bool?>((ref) => false);