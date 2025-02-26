import 'package:echo_verse/dependencies/service_locator.dart';
import 'package:echo_verse/features/authentication/data/model/user.dart';
import 'package:echo_verse/features/authentication/data/repository/auth_contract.dart';
import 'package:echo_verse/features/notification/data/repository/notification_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService implements AuthContract {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> signUp(String name, String email, String password) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    final UserModel userInfo;
    userInfo = UserModel.forRegistration(
      name: name,
      email: email,
      password: password,
      authId: userCredential.user!.uid,
      imageUrl: '',
      createdAt: DateTime.now().toIso8601String(),
      isOnline: false,
      lastActive: '',
      pushToken: '',
    );
    if (userCredential.user != null) {
      await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(userInfo.toMap());
      await userCredential.user!.updateDisplayName(name);
      await userCredential.user!.reload();
    }
    await NotificationServices().updateFcmToken();

    debugPrint('CALLED FIRESTORE ADD FUNCTION');
    debugPrint(userInfo.name);
    debugPrint(userInfo.authId);
    debugPrint(userUid);
    debugPrint(userCredential.user!.uid);
    debugPrint(userInfo.email);
  }

  @override
  Future<User?> login(String email, String password) async {
    final UserCredential userCredential = await _auth
        .signInWithEmailAndPassword(email: email, password: password);

    await NotificationServices().updateFcmToken();
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
    debugPrint('=========================================================>>>>');
    debugPrint(userModel.name);
    debugPrint(userModel.email);
    debugPrint(userModel.imageUrl);
    debugPrint(userModel.createdAt);
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
    await firebaseAut.signOut();
  }
}
