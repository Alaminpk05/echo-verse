import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_verse/dependencies/service_locator.dart';
import 'package:echo_verse/features/chat/data/model/messege.dart';
import 'package:echo_verse/features/chat/data/repository/messege_contract_repo.dart';


class MessegeRepo implements MessegeContractRepo {
  @override
  Future<void> sendMessage(String receiverId, String messege) async {
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
  }

  @override
 Stream<QuerySnapshot> receiveMessage(
      String senderId, String receiverId)  {
    List<String> ids = [senderId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');
    return firestore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('message').orderBy('timestamp',descending: false)
        .snapshots();
  }
}
