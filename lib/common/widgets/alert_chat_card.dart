import 'package:flutter/material.dart';
import 'package:tinder_clone/common/utils/coloors.dart';

class AlertChatCard extends StatelessWidget {
  const AlertChatCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 30,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Coloors.sunnyYellow,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        'Welcome to the Tinder chat room. This chat room is intended for acquaintance between users. Messages are moderated and not encrypted. If you want to be safe, exchange contacts with the person you are chatting with.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 13,
          color: Colors.white,
        ),
      ),
    );
  }
}