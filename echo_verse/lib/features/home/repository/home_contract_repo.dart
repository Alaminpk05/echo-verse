
import 'package:echo_verse/features/authentication/data/model/user.dart';
import 'package:echo_verse/features/chat/data/model/messege.dart';

abstract class HomeContractRepo {
  Future<List<UserModel>> fetchUsersInfo();
  Stream<ChatMessageModel?> getLastMessage(UserModel user);
}
