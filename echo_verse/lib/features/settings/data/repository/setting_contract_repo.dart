abstract class SettingContractServices {
  changeName(String newName);
  changePassword(String currentPassword, String newPassword);
  changeEmail(String password, String newEmail);
  Future<void>changeProfile();
}
