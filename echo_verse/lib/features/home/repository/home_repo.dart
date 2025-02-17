import 'package:echo_verse/dependencies/service_locator.dart';
import 'package:echo_verse/features/authentication/data/model/user.dart';
import 'package:echo_verse/features/chat/data/model/messege.dart';
import 'package:echo_verse/features/home/repository/home_contract_repo.dart';

class HomeRepo implements HomeContractRepo {
  @override
  Stream<List<UserModel>> fetchUsersInfo() {
    return firestore.collection('users').where('authId',isNotEqualTo: userUid).snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList());
  }

  @override
  Stream<ChatMessageModel?> getLastMessage(UserModel user) {
    List<String> ids = [userUid!, user.authId!];
    ids.sort();
    String chatRoomId = ids.join('_');

    return firestore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('message')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        return ChatMessageModel.fromJson(snapshot.docs.first.data());
      }
      return null;
    });
  }
}
