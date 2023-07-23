import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../new/domain/message_model.dart';
import '../utils/coloors.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({
    Key? key,
    required this.isSender,
    required this.haveNip,
    required this.message,
  }) : super(key: key);

  final bool isSender;
  final bool haveNip;
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      margin: EdgeInsets.only(
        top: 4,
        bottom: 4,
        left: isSender
            ? 80
            : haveNip
                ? 10
                : 15,
        right: isSender
            ? haveNip
                ? 10
                : 15
            : 80,
      ),
      child: ClipPath(
        clipper: haveNip
            ? UpperNipMessageClipperTwo(
                isSender ? MessageType.send : MessageType.receive,
                nipWidth: 8,
                nipHeight: 10,
                bubbleRadius: haveNip ? 12 : 0,
              )
            : null,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: isSender ? const Color.fromARGB(255, 244, 90, 100) : const Color.fromARGB(255, 225, 84, 138),
                borderRadius: haveNip ? null : BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(color: Colors.black38),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Padding(
                        padding: EdgeInsets.only(
                          top: 8,
                          bottom: 8,
                          left: isSender ? 10 : 15,
                          right: isSender ? 15 : 10,
                        ),
                        child: Text(
                          "${message.text}         ",
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
              ),
            ),
            Positioned(
              bottom: 3,
              right: isSender
                      ? 10
                      : 10,
              child: Text(
                      DateFormat.Hm().format(message.timeSent),
                      style: const TextStyle(
                        fontSize: 11,
                        color: Coloors.steelGray,
                      ),
                    )
            )
          ],
        ),
      ),
    );
  }
}