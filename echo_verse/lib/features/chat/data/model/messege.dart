import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType { text, image, video, audio, file }

class ChatMessageModel {
  final String senderId;
  final String receiverId;
  final String content;
  final MessageType type;
  final bool isRead;
  final String senderEmail;
  final Timestamp timestamp;

  ChatMessageModel({
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.type,
    this.isRead = false,
    required this.senderEmail,
    required this.timestamp,
  });

  // Convert ChatMessage to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'content': content,
      'type': type.toString().split('.').last,
      'isRead': isRead,
      'timestamp': timestamp,
    };
  }

  // Create ChatMessage from Firestore JSON
  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      senderId: json['senderId'],
      senderEmail: json['senderEmail'],
      receiverId: json['receiverId'],
      content: json['content'],
      type: MessageType.values
          .firstWhere((e) => e.toString().split('.').last == json['type']),
      isRead: json['isRead'] ?? false,
      timestamp: json['timestamp'] ?? Timestamp.now(),
    );
  }
}
