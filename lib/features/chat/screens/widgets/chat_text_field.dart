import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/common/helper/show_alert_dialog.dart';
import 'package:tinder_clone/common/models/user_model.dart';
import 'package:tinder_clone/common/repositories/common_messaging_repository.dart';
import 'package:tinder_clone/common/utils/coloors.dart';
import 'package:tinder_clone/common/utils/decorations.dart';
import 'package:tinder_clone/features/chat/controller/chat_controller.dart';

class ChatTextField extends ConsumerStatefulWidget {
  const ChatTextField(
      {super.key, required this.receiverUser, required this.messageController});
  final UserModel receiverUser;
  final ScrollController messageController;

  @override
  ConsumerState<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends ConsumerState<ChatTextField> {
  late TextEditingController textEditingController;
  late final ScrollController messageController;

  @override
  void initState() {
    super.initState();
    messageController = widget.messageController;
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  void sendMessage() async {
    if (textEditingController.text.trim().isEmpty) {
      showAlertDialog(context: context, message: "your_message_is_empty".tr());
    } else {
      messageController.jumpTo(messageController.position.maxScrollExtent);
      await MessagingApi().callOnFcmApiSendPushNotifications(
          widget.receiverUser.fcmToken,
          "new_message".tr(),
          textEditingController.text);
      ref.read(chatControllerProvider).sendTextMessage(
          context, textEditingController.text, widget.receiverUser.uid);
      textEditingController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              TextField(
                controller: textEditingController,
                decoration: Decorations.kTextFieldMessageDecoration
                    .copyWith(hintText: "message".tr()),
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              IconButton(
                color: Coloors.primaryColor,
                icon: Icon(Icons.send),
                onPressed: () => sendMessage(),
              ),
            ],
          )),
    );
  }
}
