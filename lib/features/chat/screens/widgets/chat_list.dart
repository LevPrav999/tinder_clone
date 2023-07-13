import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tinder_clone/common/models/message_model.dart';
import 'package:tinder_clone/common/widgets/alert_chat_card.dart';
import 'package:tinder_clone/common/widgets/date_message_card.dart';
import 'package:tinder_clone/common/widgets/loader.dart';
import 'package:tinder_clone/common/widgets/message.dart';
import 'package:tinder_clone/features/chat/controller/chat_controller.dart';

class ChatList extends ConsumerWidget {
  const ChatList({super.key, required this.userId});
  final String userId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 83),
      child: StreamBuilder<List<Message>>(
                  stream: ref.watch(chatControllerProvider).chatStream(userId),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const LoaderWidget();
                    }
                    if (snapshot.data!.isEmpty) {
                      return Column(
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
                            child: Text("You don't have any chats yet...",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    wordSpacing: 1.2,
                                    fontSize: 26.sp,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.grey.shade600)),
                          )
                        ],
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final message = snapshot.data![index];
                          final isSender = message.senderId ==
                              FirebaseAuth.instance.currentUser!.uid;
                          final haveNip = (index == 0) ||
                              (index == snapshot.data!.length - 1 &&
                                  message.senderId !=
                                      snapshot.data![index - 1].senderId) ||
                              (message.senderId !=
                                      snapshot.data![index - 1].senderId &&
                                  message.senderId ==
                                      snapshot.data![index + 1].senderId) ||
                              (message.senderId !=
                                      snapshot.data![index - 1].senderId &&
                                  message.senderId !=
                                      snapshot.data![index + 1].senderId);
    
                          final isShowDateCard = (index == 0) ||
                              ((index == snapshot.data!.length - 1) &&
                                  (message.timeSent.day >
                                      snapshot.data![index - 1].timeSent.day)) ||
                              (message.timeSent.day >
                                      snapshot.data![index - 1].timeSent.day &&
                                  message.timeSent.day <=
                                      snapshot.data![index + 1].timeSent.day);
    
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
                        });
                  }),
    );
  }
}
