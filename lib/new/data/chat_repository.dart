import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/chat_model.dart';
import '../domain/message_model.dart';
import '../domain/user_model.dart';

final chatRepositoryProvider = Provider((ref) => ChatRepository(
    firestore: FirebaseFirestore.instance, auth: FirebaseAuth.instance));

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  late StreamSubscription<QuerySnapshot> subscription;

  ChatRepository({required this.firestore, required this.auth});


  Stream<List<ChatConversation>> getAllLastMessageList(String uid) {
    return firestore
        .collection('users')
        .doc(uid)
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

  Stream<QuerySnapshot> getChatStream(String uid, String recieverUserId){
    return firestore
        .collection('users')
        .doc(uid)
        .collection('chats')
        .doc(recieverUserId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots();
  }

  void closeChatStream(){
    subscription.cancel();
  }

  Future<void> sendTextMessage(
      {
      required String text,
      required String recieverUserId,
      required UserModel senderUser,
      required DateTime timeSent,
      required String messageId,
      required UserModel? receiverUserData
      }) async {
    _saveDataToContactsSubcollection(
          senderUser, receiverUserData!, text, timeSent);

      _saveMessageToMessagesSubcollection(
          receiverUserData, text, timeSent, messageId, senderUser);
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
