import 'package:chatroom/screens/ChatScreen.dart';
import 'package:chatroom/services/AuthService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                child: LottieBuilder.asset(
                  "assets/animations/hello.json",
                ),
              ),
              Positioned(
                top: size.height * 0.5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "New Here?",
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Try Login...",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment(0, 0.8),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: size.width,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          await _authService.loginWithGoogle();
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (cxt) => ChatScreen(),
                            ),
                          );
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Text(
                        "Login with Google",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
