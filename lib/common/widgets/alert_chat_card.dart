import 'package:easy_localization/easy_localization.dart';
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
      child: Text(
        'welcome_to_chat_room'.tr(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 13,
          color: Colors.white,
        ),
      ),
    );
  }
}