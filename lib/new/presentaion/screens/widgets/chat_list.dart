import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tinder_clone/new/presentaion/controllers/tabs/chats_tab_controller.dart';
import 'package:tinder_clone/new/presentaion/states/chat_state.dart';

import '../../../../common/widgets/alert_chat_card.dart';
import '../../../../common/widgets/date_message_card.dart';
import '../../../../common/widgets/loader.dart';
import '../../../../common/widgets/message.dart';
import '../../../domain/message_model.dart';

class ChatList extends ConsumerStatefulWidget {
  const ChatList({super.key, required this.userId, required this.messageController});
  final String userId;
  final ScrollController messageController;


  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {

  late final ScrollController messageController;

  @override
  void initState() {
    messageController = widget.messageController;
    ref.read(chatProvider.notifier).chatStream(widget.userId);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

 @override
  Widget build(BuildContext context) {

    List<Message>? messages = ref.watch(userChatListStateProvider);

    return Padding(
      padding: const EdgeInsets.only(bottom: 83),
      child: messages == null ? const LoaderWidget() : messages.isEmpty ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: Image(
                                width: 300.w,
                                height: 150.h,
                                fit: BoxFit.cover,
                                image: AssetImage('assets/images/sorry.png')),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: Text("you_dont_have_any_chats_yet".tr(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    wordSpacing: 1.2,
                                    fontSize: 26.sp,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey.shade600)),
                          )
                        ],
                      ) : ListView.builder(
                        controller: messageController,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          final isSender = message.senderId ==
                              FirebaseAuth.instance.currentUser!.uid;
                          final haveNip = (index == 0) ||
                              (index == messages.length - 1 &&
                                  message.senderId !=
                                      messages[index - 1].senderId) ||
                              (message.senderId !=
                                      messages[index - 1].senderId &&
                                  message.senderId ==
                                      messages[index + 1].senderId) ||
                              (message.senderId !=
                                      messages[index - 1].senderId &&
                                  message.senderId !=
                                      messages[index + 1].senderId);
    
                          final isShowDateCard = (index == 0) ||
                              ((index == messages.length - 1) &&
                                  (message.timeSent.day >
                                      messages[index - 1].timeSent.day)) ||
                              (message.timeSent.day >
                                      messages[index - 1].timeSent.day &&
                                  message.timeSent.day <=
                                      messages[index + 1].timeSent.day);
    
                          return Column(
                            children: [
                              if (index == 0) const AlertChatCard(),
                              if (isShowDateCard)
                                DateMessageCard(date: message.timeSent),
                              MessageCard(
                                isSender: isSender,
                                haveNip: haveNip,
                                message: message,
                              ),
                            ],
                          );
                        }));
}
}