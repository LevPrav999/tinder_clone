import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/message_model.dart';

final userChatListStateProvider = StateProvider<List<Message>?>((ref) => null);