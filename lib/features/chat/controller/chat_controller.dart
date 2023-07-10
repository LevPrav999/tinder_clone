// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/common/models/chat_model.dart';
import 'package:tinder_clone/common/models/message_model.dart';
import 'package:tinder_clone/features/auth/controller/auth_controller.dart';
import 'package:tinder_clone/features/chat/repositories/chat_repository.dart';

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

  Stream<List<ChatConversation>> getAllLastMessageList() {
    return chatRepository.getAllLastMessageList();
  }

  void sendTextMessage(
      BuildContext context, String text, String receiverUserId) async{
    
    final user = await ref.read(userInfoAuthProvider.future);
    chatRepository.sendTextMessage(
            context: context,
            text: text,
            recieverUserId: receiverUserId,
            senderUser: user!);

  }

  Stream<List<Message>> chatStream(String recieverUserId){
    return chatRepository.getChatStream(recieverUserId);
  }
}
