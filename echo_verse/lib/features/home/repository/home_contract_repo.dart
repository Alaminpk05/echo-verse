import 'package:echo_verse/features/authentication/data/model/user.dart';

abstract class HomeContractRepo {
  Future<List<UserModel>> fetchUsersInfo();
}
