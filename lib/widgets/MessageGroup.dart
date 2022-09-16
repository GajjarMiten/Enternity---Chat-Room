import 'package:chatroom/models/Message.dart';
import 'package:chatroom/widgets/MessageBox.dart';
import 'package:flutter/material.dart';

class MessageGroup extends StatefulWidget {
  final List<Message> messages;
  const MessageGroup({Key? key, required this.messages}) : super(key: key);

  @override
  State<MessageGroup> createState() => _MessageGroupState();
}

class _MessageGroupState extends State<MessageGroup> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      for (int i = 0; i < widget.messages.length; i++)
        MessageBox(
          message: widget.messages[i],
          isLast: i == widget.messages.length - 1,
          isFirst: i == 0,
        ),
    ]);
  }
}
