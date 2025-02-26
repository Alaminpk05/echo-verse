import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_verse/dependencies/service_locator.dart';
import 'package:echo_verse/features/chat/data/model/messege.dart';
import 'package:echo_verse/features/chat/data/repository/messege_contract_repo.dart';
import 'package:echo_verse/features/notification/data/repository/notification_repo.dart';
import 'package:flutter/services.dart';

class MessegeRepo implements MessegeContractRepo {
  @override
  Future<void> sendMessage(String receiverId, String messege) async {
    final sender =
        await FirebaseFirestore.instance.collection('users').doc(userUid).get();
    final receiver = await FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .get();

    if (!receiver.exists || !sender.exists) return;
    String? receiverToken = receiver['pushToken'];
    ChatMessageModel newMessage = ChatMessageModel(
        senderId: userUid!,
        receiverId: receiverId,
        content: messege,
        type: MessageType.text,
        timestamp: Timestamp.now(),
        senderEmail: userEmail!);

    List<String> ids = [userUid!, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');
    await firestore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('message')
        .add(newMessage.toJson());
    // final pushToken=await firestore.collection('users').doc(userUid).get();
    // debugPrint(pushToken);

    await NotificationServices().updateFcmToken();
    if (receiverToken != null && receiverToken.isNotEmpty) {
      NotificationServices()
          .sendPushNotification(receiverToken, sender['name'], messege);
    }
  }

  @override
  Stream<QuerySnapshot> receiveMessage(String senderId, String receiverId) {
    List<String> ids = [senderId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');
    return firestore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('message')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  @override
  Future<void> deleteMessage(String senderId, String receiverId, String docId) {
    List<String> ids = [senderId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');
    return firestore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('message')
        .doc(docId)
        .delete();
  }

  @override
  void copyText({required context, required String message}) {
    Clipboard.setData(ClipboardData(text: message)).then((_) {
      customSnackBar.snackBar(
          context, 'Copied to clipboard', ContentType.success, 'Copied');
    });
  }

  @override
  Future<void> updateActiveStatus(bool isOnline) async {
    firestore.collection('users').doc(userUid).update({
      'isOnline': isOnline,
      'lastActive': DateTime.now().millisecondsSinceEpoch.toString()
    });
  }
}
