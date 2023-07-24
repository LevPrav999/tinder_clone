import 'package:flutter/material.dart';

import '../../../../common/utils/coloors.dart';

class ChatScrollButton extends StatefulWidget {
  const ChatScrollButton({super.key, required this.messageController});

  final ScrollController messageController;

  @override
  State<ChatScrollButton> createState() => _ChatScrollButtonState();
}

class _ChatScrollButtonState extends State<ChatScrollButton> {
  late final ScrollController messageController;

  bool showScrollButton = false;

  @override
  void initState() {
    super.initState();
    messageController = widget.messageController;
    messageController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    messageController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (messageController.position.maxScrollExtent.toInt() < 350) {
      setState(() {
        showScrollButton = false;
      });
    } else {
      setState(() {
        showScrollButton = messageController.position.pixels <
            MediaQuery.of(context).size.height / 2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return showScrollButton
        ? Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 78.0),
              child: FloatingActionButton(
                onPressed: () {
                  messageController.animateTo(
                    messageController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                backgroundColor: Coloors.skyBlue,
                child: const Icon(Icons.arrow_downward),
              ),
            ),
          )
        : Container();
  }
}
