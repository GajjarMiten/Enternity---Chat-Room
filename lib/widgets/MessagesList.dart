import 'package:chatroom/models/Message.dart';
import 'package:chatroom/services/MessageService.dart';
import 'package:chatroom/widgets/MessageBox.dart';
import 'package:chatroom/widgets/MessageGroup.dart';
import 'package:flutter/material.dart';

class MessagesList extends StatefulWidget {
  const MessagesList({Key? key}) : super(key: key);

  @override
  State<MessagesList> createState() => _MessagesListState();
}

class _MessagesListState extends State<MessagesList> {
  final MessageService _messageService = MessageService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
      stream: _messageService.getMessages(),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error}"),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final List<List<Message>> groups = _messageService.groupMessages(
          snapshot.data,
        );


        return ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom:100),
          itemCount: groups.length,
          itemBuilder: (BuildContext context, int index) {
            return MessageGroup(messages: groups[index]);
          },
        );
      },
    );
  }
}
