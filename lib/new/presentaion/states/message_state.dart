import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessageNotifier extends StateNotifier<RemoteMessage?> {
  MessageNotifier() : super(null);

  void setMessage(RemoteMessage? message) {
    state = message;
  }
}

final messageProvider = StateNotifierProvider<MessageNotifier, RemoteMessage?>((ref) => MessageNotifier());
