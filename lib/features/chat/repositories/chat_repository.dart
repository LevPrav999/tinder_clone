import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/common/helper/show_alert_dialog.dart';
import 'package:tinder_clone/common/models/chat_model.dart';
import 'package:tinder_clone/common/models/message_model.dart';
import 'package:tinder_clone/common/models/user_model.dart';
import 'package:tinder_clone/features/chat/controller/chat_controller.dart';
import 'package:uuid/uuid.dart';

final chatRepositoryProvider = Provider((ref) => ChatRepository(
    firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance));

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  late StreamSubscription<QuerySnapshot> subscription;

  ChatRepository({required this.firestore, required this.auth});


  Stream<List<ChatConversation>> getAllLastMessageList() {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .asyncMap((event) async {
      List<ChatConversation> contacts = [];
      for (var document in event.docs) {
        final lastMessage = ChatConversation.fromMap(document.data());
        final userData = await firestore.collection('users').doc(lastMessage.contactId).get();
        final user = UserModel.fromMap(userData.data()!);
        contacts.add(
          ChatConversation(
            name: user.name,
            profilePic: user.avatar,
            contactId: lastMessage.contactId,
            timeSent: lastMessage.timeSent,
            lastMessage: lastMessage.lastMessage,
            fcmToken: lastMessage.fcmToken
          )
        );
      }
      return contacts;
    });
  }

  void getChatStream({required String recieverUserId, required WidgetRef ref}){
    subscription = firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .listen((event) {
    List<Message> messages = [];
    for (var message in event.docs) {
      messages.add(Message.fromMap(message.data()));
    }
    ref.read(userChatListStateProvider.notifier).update((state) => messages);
  });
  }

  void closeChatStream(){
    subscription.cancel();
  }

  void sendTextMessage(
      {required BuildContext context,
      required String text,
      required String recieverUserId,
      required UserModel senderUser}) async {
    try {
      var timeSent = DateTime.now();
      UserModel receiverUserData;
      var userDataMap =
          await firestore.collection('users').doc(recieverUserId).get();

      receiverUserData = UserModel.fromMap(userDataMap.data()!);

      var messageId = const Uuid().v1();

      _saveDataToContactsSubcollection(
          senderUser, receiverUserData, text, timeSent);

      _saveMessageToMessagesSubcollection(
          receiverUserData, text, timeSent, messageId, senderUser);
    } catch (e) {
      showAlertDialog(context: context, message: e.toString());
    }
  }

  void _saveDataToContactsSubcollection(
    UserModel senderUserData,
    UserModel recieverUserData,
    String text,
    DateTime timeSent,
  ) async {
    var recieverChatContact = ChatConversation(
        name: senderUserData.name,
        profilePic: senderUserData.avatar,
        contactId: senderUserData.uid,
        timeSent: timeSent,
        lastMessage: text,
        fcmToken: senderUserData.fcmToken
        );

    await firestore
        .collection('users')
        .doc(recieverUserData.uid)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .set(recieverChatContact.toMap());

    // --------------

    var senderChatContact = ChatConversation(
        name: recieverUserData.name,
        profilePic: recieverUserData.avatar,
        contactId: recieverUserData.uid,
        timeSent: timeSent,
        lastMessage: text,
        fcmToken: recieverUserData.fcmToken
        );

    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(recieverUserData.uid)
        .set(senderChatContact.toMap());
  }

  void _saveMessageToMessagesSubcollection(UserModel receiverUser, String text,
      DateTime timeSent, String messageId, UserModel senderUser) async {
    final message = Message(
        senderId: senderUser.uid,
        recieverId: receiverUser.uid,
        text: text,
        timeSent: timeSent,
        messageId: messageId,
        isSeen: false);

    await firestore
        .collection('users')
        .doc(senderUser.uid)
        .collection('chats')
        .doc(receiverUser.uid)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());

    await firestore
        .collection('users')
        .doc(receiverUser.uid)
        .collection('chats')
        .doc(senderUser.uid)
        .collection('messages')
        .doc(messageId)
        .set(message.toMap());
  }
}
