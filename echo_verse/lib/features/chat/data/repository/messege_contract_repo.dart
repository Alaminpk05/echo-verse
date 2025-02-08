import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MessegeContractRepo {
  Future<void> sendMessage(String receiverId, String messege);
 Stream<QuerySnapshot> receiveMessage(
      String senderId, String receiverId);
}
