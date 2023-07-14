import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tinder_clone/common/models/user_model.dart';
import 'package:tinder_clone/common/utils/coloors.dart';
import 'package:tinder_clone/features/auth/controller/auth_controller.dart';
import 'package:tinder_clone/features/chat/screens/widgets/chat_list.dart';
import 'package:tinder_clone/features/chat/screens/widgets/chat_text_field.dart';

class ChatScreen extends ConsumerWidget {
  static const String routeName = '/chat-screen';
  const ChatScreen({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Coloors.secondaryHeaderColor,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            borderRadius: BorderRadius.circular(20),
            child: Row(
              children: [
                const Icon(Icons.arrow_back),
                Hero(
                  tag: 'profile',
                  child: Container(
                    width: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(user.avatar),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          title: InkWell(
            onTap: () {
              // to profile
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 3),
                  StreamBuilder(
                    stream: ref
                        .read(authControllerProvider)
                        .getUserPresenceStatus(uid: user.uid),
                    builder: (_, snapshot) {
                      if (snapshot.data == null) {
                        return const SizedBox();
                      }

                      final singleUserModel = snapshot.data!;
                      // final lastMessage = lastSeenMessage(singleUserModel.lastSeen);

                      return Text(
                        singleUserModel.isOnline ? 'online'.tr() : "offline".tr(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Stack(
          children: [
            ChatList(userId: user.uid),
            ChatTextField(receiverUserId: user.uid,)
          ],
        ));
  }
}
