import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/new/data/auth_repository.dart';
import 'package:tinder_clone/new/data/chat_repository.dart';
import 'package:tinder_clone/new/data/user_repository.dart';
import 'package:tinder_clone/new/presentaion/states/chat_state.dart';
import 'package:uuid/uuid.dart';

import '../../common/errors/errors.dart';
import '../domain/chat_model.dart';
import '../domain/message_model.dart';
import '../domain/user_model.dart';

final chatServiceProvider = Provider<ChatService>((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatService(ref, chatRepository);
});

class ChatService {
  ChatService(this.ref, this.chatRepository);
  final Ref ref;
  final ChatRepository chatRepository;

  late StreamSubscription<QuerySnapshot> subscription;

  Stream<List<ChatConversation>> getAllLastMessageList() {
    String uid = ref.read(authRepositoryProvider).authUserUid!;

    return chatRepository.getAllLastMessageList(uid);
  }

  Future<void> getChatStream(String recieverUserId) async {
    String uid = ref.read(authRepositoryProvider).authUserUid!;

    chatRepository.getChatStream(uid, recieverUserId).listen((event) {
      List<Message> messages = [];
      for (var message in event.docs) {
        messages.add(Message.fromMap(message.data() as Map<String, dynamic>));
      }
      List<Message>? oldListValue =
          ref.read(userChatListStateProvider.notifier).state;
      if (oldListValue == null || oldListValue.length != messages.length) {
        ref
            .read(userChatListStateProvider.notifier)
            .update((state) => messages);
      }
    });
  }

  void closeChatStream() {
    subscription.cancel();
  }

  Future<Either<Failture, void>> sendTextMessage(
      {required String text,
      required String recieverUserId,
      required UserModel senderUser}) async {
    try {
      var timeSent = DateTime.now();
      UserModel? receiverUserData =
          await ref.read(userRepositoryProvider).getUserInfo(recieverUserId);

      var messageId = const Uuid().v1();
      return Right(await chatRepository.sendTextMessage(
          text: text,
          recieverUserId: recieverUserId,
          senderUser: senderUser,
          timeSent: timeSent,
          messageId: messageId,
          receiverUserData: receiverUserData));
    } catch (e) {
      return Left(FirestoreError("Error while sending message!"));
    }
  }
}
