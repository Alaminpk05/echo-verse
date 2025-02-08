import 'package:echo_verse/features/authentication/data/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthContract {
  Future<UserCredential?> signUp(String name, String email, String password);
  Future<User?> login(String email, String password);

  Future<void> resetPassword(String email);
  Future<void> signOut();
  Future<void> saveUserInfoInDatabase(UserModel userModel);
 
  Future<void> deleteAccount(String email, String password);
}
