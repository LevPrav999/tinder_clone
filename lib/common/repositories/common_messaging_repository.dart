import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/common/states/message_state.dart';

class MessagingApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> _handleBackgroundMessage(RemoteMessage message) async {
    print("Title: ${message.notification?.title}");
    print("Body: ${message.notification?.body}");
    print("Payload: ${message.data}");
  }

  void initNotifications(WidgetRef ref) async {
    try {
      await _firebaseMessaging.requestPermission();

      final fcmToken = await _firebaseMessaging.getToken();
      print(fcmToken);

      try {
        FirebaseMessaging.onBackgroundMessage(_handleBackgroundMessage);
      } catch (e) {
        print(e.toString());
      }

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Handling a foreground message: ${message.messageId}');
        print('Message data: ${message.data}');
        print('Message notification: ${message.notification?.title}');
        print('Message notification: ${message.notification?.body}');

        final messageProviderState = ref.read(messageProvider.notifier);
        messageProviderState.setMessage(message);
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
