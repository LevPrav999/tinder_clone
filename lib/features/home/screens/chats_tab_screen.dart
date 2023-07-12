import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tinder_clone/common/models/chat_model.dart';
import 'package:tinder_clone/common/models/user_model.dart';
import 'package:tinder_clone/common/utils/coloors.dart';
import 'package:tinder_clone/features/chat/controller/chat_controller.dart';
import 'package:tinder_clone/features/chat/screens/chat_screen.dart';

class ChatsTabScreen extends ConsumerWidget {
  const ChatsTabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: StreamBuilder<List<ChatConversation>>(
      stream: ref.watch(chatControllerProvider).getAllLastMessageList(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Coloors.primaryColor,
            ),
          );
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
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final lastMessageData = snapshot.data![index];
            return ListTile(
              onTap: () {
                Navigator.pushNamed(context, ChatScreen.routeName,
                    arguments: UserModel(
                        uid: lastMessageData.contactId,
                        name: lastMessageData.name,
                        avatar: lastMessageData.profilePic,
                        age: {},
                        sex: "",
                        city: "",
                        bio: "",
                        sexFind: "",
                        isOnline: true,
                        blocked: [],
                        liked: [],
                        pending: [],
                        tags: []
                        ));
              },
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    lastMessageData.name,
                    style: TextStyle(fontSize: 16.w),
                  ),
                  Text(
                    DateFormat.Hm().format(lastMessageData.timeSent),
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  lastMessageData.lastMessage,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              leading: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  lastMessageData.profilePic,
                ),
                radius: 32,
              ),
            );
          },
        );
      },
    ));
  }
}
