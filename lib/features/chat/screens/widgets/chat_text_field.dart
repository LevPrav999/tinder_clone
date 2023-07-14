import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/common/helper/show_alert_dialog.dart';
import 'package:tinder_clone/common/utils/coloors.dart';
import 'package:tinder_clone/common/utils/decorations.dart';
import 'package:tinder_clone/features/chat/controller/chat_controller.dart';

class ChatTextField extends ConsumerStatefulWidget {
  const ChatTextField({super.key, required this.receiverUserId});
  final String receiverUserId;

  @override
  ConsumerState<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends ConsumerState<ChatTextField> {

  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }
  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  void sendMessage(){
    if(textEditingController.text.trim().isEmpty){
      showAlertDialog(context: context, message: "your_message_is_empty".tr());
    }else{
      ref.read(chatControllerProvider).sendTextMessage(context, textEditingController.text, widget.receiverUserId);
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