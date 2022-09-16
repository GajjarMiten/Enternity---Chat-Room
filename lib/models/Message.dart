import 'dart:convert';

import 'package:flutter/foundation.dart';

class Message {
  String id;
  String message;
  String senderId;
  String senderProfilePhoto;
  String senderName;
  DateTime createdAt;
  List<String> files;
  Message({
    required this.id,
    required this.message,
    required this.senderId,
    required this.senderProfilePhoto,
    required this.senderName,
    required this.createdAt,
    required this.files,
  });

  Message copyWith({
    String? id,
    String? message,
    String? senderId,
    String? senderProfilePhoto,
    String? senderName,
    DateTime? createdAt,
    List<String>? files,
  }) {
    return Message(
      id: id ?? this.id,
      message: message ?? this.message,
      senderId: senderId ?? this.senderId,
      senderProfilePhoto: senderProfilePhoto ?? this.senderProfilePhoto,
      senderName: senderName ?? this.senderName,
      createdAt: createdAt ?? this.createdAt,
      files: files ?? this.files,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'message': message,
      'senderId': senderId,
      'senderProfilePhoto': senderProfilePhoto,
      'senderName': senderName,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'files': files,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] ?? '',
      message: map['message'] ?? '',
      senderId: map['senderId'] ?? '',
      senderProfilePhoto: map['senderProfilePhoto'] ?? '',
      senderName: map['senderName'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      files: List<String>.from(map['files']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) => Message.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Message(id: $id, message: $message, senderId: $senderId, senderProfilePhoto: $senderProfilePhoto, senderName: $senderName, createdAt: $createdAt, files: $files)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Message &&
      other.id == id &&
      other.message == message &&
      other.senderId == senderId &&
      other.senderProfilePhoto == senderProfilePhoto &&
      other.senderName == senderName &&
      other.createdAt == createdAt &&
      listEquals(other.files, files);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      message.hashCode ^
      senderId.hashCode ^
      senderProfilePhoto.hashCode ^
      senderName.hashCode ^
      createdAt.hashCode ^
      files.hashCode;
  }
}
