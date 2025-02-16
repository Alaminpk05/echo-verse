import 'package:echo_verse/dependencies/service_locator.dart';
import 'package:echo_verse/features/authentication/data/model/user.dart';
import 'package:echo_verse/features/authentication/data/repository/auth_contract.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService implements AuthContract {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<UserCredential?> signUp(
      String name, String email, String password) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (userCredential.user != null) {
      await userCredential.user!.updateDisplayName(name);
      await userCredential.user!.reload();

      return userCredential;
    }
    return null;
  }

  @override
  Future<User?> login(String email, String password) async {
    final UserCredential userCredential = await _auth
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> saveUserInfoInDatabase(UserModel userModel) async {
    await firestore.collection('users').doc(userUid).set(userModel.toMap());
  }

  @override
  Future<void> deleteAccount(String email, String password) async {
    final user = firebaseAut.currentUser;

    // Reauthenticate the user before account deletion
    final credential = EmailAuthProvider.credential(
      email: user!.email!,
      password: password,
    );

    await user.reauthenticateWithCredential(credential);
     await firestore.collection('users').doc(userUid).delete();
    await user.delete();
   
  }
}
