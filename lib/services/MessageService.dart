import 'package:chatroom/models/Message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageService {
  MessageService._();

  static final MessageService _instance = MessageService._();

  static MessageService get instance => _instance;

  factory MessageService() {
    return _instance;
  }

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(Message message) async {
    final DocumentReference messageRef =
        _firestore.collection("messages").doc();

    message.id = messageRef.id;

    await messageRef.set(message.toMap());
  }

  Stream<List<Message>> getMessages() {
    return _firestore
        .collection("messages")
        .orderBy("createdAt")
        .snapshots()
        .map((event) {
      return event.docs.map((e) => Message.fromMap(e.data())).toList();
    });
  }

  List<List<Message>> groupMessages(List<Message> messages) {
    final List<List<Message>> groups = [];

    for (var i = 0; i < messages.length; i++) {
      final Message message = messages[i];

      if (i == 0) {
        groups.add([message]);
      } else {
        final Message previousMessage = messages[i - 1];

        if (previousMessage.senderId == message.senderId) {
          groups.last.add(message);
        } else {
          groups.add([message]);
        }
      }
    }

    return groups;
  }
}
