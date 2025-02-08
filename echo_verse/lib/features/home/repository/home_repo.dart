import 'package:echo_verse/dependencies/service_locator.dart';
import 'package:echo_verse/features/authentication/data/model/user.dart';
import 'package:echo_verse/features/home/repository/home_contract_repo.dart';

class HomeRepo implements HomeContractRepo {
   @override
  Future<List<UserModel>> fetchUsersInfo() async {
    final querySnapshot = await firestore.collection('users').get();
    final userList = querySnapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();


    return userList;
  }

}
