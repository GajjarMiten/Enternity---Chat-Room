import 'package:chatroom/extensions/Message.dart';
import 'package:chatroom/models/Message.dart';
import 'package:flutter/material.dart';

class MessageBox extends StatefulWidget {
  final Message message;
  final bool isLast;
  final bool isFirst;
  const MessageBox(
      {Key? key,
      required this.message,
      required this.isLast,
      required this.isFirst})
      : super(key: key);

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> layout = [
      SizedBox(
        height: 40,
        width: 40,
        child: (widget.isLast)
            ? Hero(
              tag: widget.message.senderId,
              child: CircleAvatar(
                // key: Key(widget.message.senderProfilePhoto),
                backgroundImage:
                    NetworkImage(widget.message.senderProfilePhoto),
              ),
            )
            : Container(),
      ),
      SizedBox(
        width: 10,
      ),
      Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: widget.message.isMe
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: !widget.message.isMe && widget.isLast
                ? Radius.circular(0)
                : Radius.circular(20),
            bottomRight: widget.message.isMe && widget.isLast
                ? Radius.circular(0)
                : Radius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (widget.isFirst && !widget.message.isMe)
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      widget.message.senderName,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                      ),
                    ),
                  )
                : Container(),
            Text(
              widget.message.message,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment:
          widget.message.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: widget.message.isMe ? layout.reversed.toList() : layout,
    );
  }
}
