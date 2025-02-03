import 'package:echo_verse/features/authentication/data/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthContract {
  Future<UserCredential?> signUp(String name, String email, String password);
  Future<User?> login(String email, String password);
  Future<void> signOut();
  Future<void> resetPassword(String email);

  Future<void> saveUserSignUpInfo(UserModel userModel);
  Future<List<UserModel>> fetchUserSignUpInfo();
}
