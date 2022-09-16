import 'package:chatroom/models/Message.dart';
import 'package:chatroom/services/AuthService.dart';
import 'package:chatroom/services/MessageService.dart';
import 'package:flutter/material.dart';
import 'dart:math' show pi;

class InputBox extends StatefulWidget {
  const InputBox({Key? key}) : super(key: key);

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  final TextEditingController _controller = TextEditingController();

  final AuthService _authService = AuthService();
  final MessageService _messageService = MessageService();

  Future<void> sendMessage() async {
    if (_controller.text.isNotEmpty) {
      final user = _authService.user;

      final message = Message(
        id: "",
        message: _controller.text,
        senderId: user!.uid,
        senderProfilePhoto: user.photoURL ?? "",
        senderName: user.displayName ?? user.email?.split("@").first ?? "",
        createdAt: DateTime.now(),
        files: [],
      );

      await _messageService.sendMessage(message);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onSubmitted: (value) {
        sendMessage();
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(30),
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(30),
          ),
          // borderSide: BorderSide.none,
        ),
        fillColor: Color(0xffFDF2FD),
        filled: true,
        hintText: "Type a message",
        suffixIcon: Container(
          child: IconButton(
            onPressed: () {
              sendMessage();
            },
            icon: Icon(Icons.send),
          ),
        ),
      ),
    );
  }
}
