import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/new/data/auth_repository.dart';
import 'package:tinder_clone/new/data/chat_repository.dart';
import 'package:tinder_clone/new/data/user_repository.dart';
import 'package:uuid/uuid.dart';

import '../domain/chat_model.dart';
import '../domain/user_model.dart';

final chatServiceProvider = Provider<ChatService>((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatService(ref, chatRepository);
});

class ChatService{
  ChatService(this.ref, this.chatRepository);
  final Ref ref;
  final ChatRepository chatRepository;

  Stream<List<ChatConversation>> getAllLastMessageList() {
    String uid = ref.read(authRepositoryProvider).authUserUid!;

    return chatRepository.getAllLastMessageList(uid);
  }

  Future<void> getChatStream(String uid, String recieverUserId) async{
    String uid = ref.read(authRepositoryProvider).authUserUid!;

    await chatRepository.getChatStream(uid, recieverUserId);
  }

  void closeChatStream(){
    chatRepository.closeChatStream();
  }

  Future<void> sendTextMessage(
      {required BuildContext context,
      required String text,
      required String recieverUserId,
      required UserModel senderUser
      }) async {
          var timeSent = DateTime.now();
      UserModel? receiverUserData = await ref.read(userRepositoryProvider).getUserInfo(recieverUserId);

      var messageId = const Uuid().v1();
        await chatRepository.sendTextMessage(context: context, text: text, recieverUserId: recieverUserId, senderUser: senderUser, timeSent: timeSent, messageId: messageId, receiverUserData: receiverUserData);
      }
}