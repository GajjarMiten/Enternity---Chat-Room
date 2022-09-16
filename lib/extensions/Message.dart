import 'package:chatroom/models/Message.dart';
import 'package:chatroom/services/AuthService.dart';


extension VerifyIsMe on Message {
  bool get isMe => this.senderId == AuthService.instace.user?.uid;
}
