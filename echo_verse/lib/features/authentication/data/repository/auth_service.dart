import 'package:echo_verse/features/authentication/data/repository/auth_contract.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService implements AuthContract {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Future<UserCredential?> signUp(
      String name, String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(name);
        await userCredential.user!.reload();
      }
      return userCredential;
    } catch (e) {
      debugPrint("User creation unsuccessful");

      rethrow;
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      debugPrint("Login failed ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      debugPrint("Sign-out failed${e.toString()}");
    }
  }
}
