import 'package:chatroom/widgets/InputBox.dart';
import 'package:chatroom/widgets/MessagesList.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: 150,
              alignment: Alignment.center,
              child: Text(
                "Chat Room",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(20),
                height: size.height - 160,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Colors.white,
                ),
                child: Stack(
                  children: [
                    GestureDetector(
                        onTap: () =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        child: Container(
                            height: size.height - 250, child: MessagesList())),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: InputBox(),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
