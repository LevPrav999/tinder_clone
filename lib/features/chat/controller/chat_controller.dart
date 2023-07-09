// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/common/models/user_model.dart';
import 'package:tinder_clone/features/chat/repositories/chat_repository.dart';
import 'package:tinder_clone/features/home/controller/user_controller.dart';

final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(chatRepository: chatRepository, ref: ref);
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;
  ChatController({
    required this.chatRepository,
    required this.ref,
  });

  void sendTextMessage(
      BuildContext context, String text, UserModel receiverUser) {
    ref.read(userDataProvider).whenData((user) =>
        chatRepository.sendTextMessage(
            context: context,
            text: text,
            recieverUserId: receiverUser.uid,
            senderUser: user));
  }
}
