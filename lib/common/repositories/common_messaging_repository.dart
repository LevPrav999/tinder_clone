import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/secret.dart';
import 'package:tinder_clone/src/presentaion/states/message_state.dart';

class MessagingApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> callOnFcmApiSendPushNotifications(
      String fcmToken, String title, String body) async {
    try {

      // non-commercial !!!
      const String serverKey = Secrets.serverKey;
      const String fcmUrl = 'https://fcm.googleapis.com/fcm/send';

      final Map<String, dynamic> notification = {
        'to': fcmToken,
        'notification': {
          'title': title,
          'body': body,
          'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        },
      };

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverKey',
      };

      await http.post(
          Uri.parse(fcmUrl),
          headers: headers,
          body: jsonEncode(notification),
        );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _handleBackgroundMessage(RemoteMessage message) async {}

  Future<String?> getToken() async {
    try {
      final fcmToken = await _firebaseMessaging.getToken();
      return fcmToken!;
    } catch (e) {
      return null;
    }
  }

  void initNotifications(WidgetRef ref) async {
    try {
      await _firebaseMessaging.requestPermission();

      try {
        FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
      } catch (e) {
        print(e.toString());
      }

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        final messageProviderState = ref.read(messageProvider.notifier);
        messageProviderState.setMessage(message);
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
