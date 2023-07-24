import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/new/application/chat_service.dart';
import 'package:tinder_clone/new/presentaion/states/user_state.dart';

import '../../../domain/chat_model.dart';

final chatProvider = AsyncNotifierProvider<ChatsTabNotifier, String>(ChatsTabNotifier.new);

class ChatsTabNotifier extends AsyncNotifier<String> {
  @override
  FutureOr<String> build() {
    return "";
  }

  Stream<List<ChatConversation>> getAllLastMessageList() {
    return ref.read(chatServiceProvider).getAllLastMessageList();
  }

  void sendTextMessage(String text, String receiverUserId) async{
    
    final user = ref.read(userStateProvider);
    var result = ref.read(chatServiceProvider).sendTextMessage(
            text: text,
            recieverUserId: receiverUserId,
            senderUser: user!);

    result.fold((left) {
      state = AsyncValue.error(left.message, StackTrace.empty);
    }, (right) => null);

  }

  void chatStream(String recieverUserId){
   ref.read(chatServiceProvider).getChatStream(recieverUserId);
  }

  void closeChatStream(){
    ref.read(chatServiceProvider).closeChatStream();
  }
}