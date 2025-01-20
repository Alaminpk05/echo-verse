import 'package:echo_verse/core/errors/firebase/exception.dart';
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
    } on FirebaseAuthException catch (e) {
      debugPrint('Sign-up failed: ${e.message}');
      throw FirebaseAuthExceptionHandler.handleException(e);
    } catch (e) {
      debugPrint('Unexpected error during sign-up: $e');

      throw 'An unexpected error occurred during sign-up. Please try again.';
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthExceptionHandler.handleException(e);
    } catch (e) {
       debugPrint('Unexpected error during login: $e');
      throw 'An unexpected error occurred during login. Please try again.';
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
       debugPrint('Sign-out failed: $e');
      throw 'An error occurred while signing out. Please try again.';
    }
  }
}
