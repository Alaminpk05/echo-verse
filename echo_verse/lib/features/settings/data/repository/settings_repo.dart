import 'package:echo_verse/dependencies/service_locator.dart';
import 'package:echo_verse/features/settings/data/repository/setting_contract_repo.dart';

class SettingService implements SettingContractServices {
  @override
  Future<void>changeName(String newName) async {
    await firebaseAut.currentUser!.updateDisplayName(newName);
  }
  @override
  Future<void>changeEmail(String password,String newEmail) async {
    await firebaseAut.currentUser!.verifyBeforeUpdateEmail(newEmail);
  }
  @override
  Future<void>changePassword(String currentPassword,String newPassword) async {
    await firebaseAut.currentUser!.updatePassword(newPassword);
  }

}
