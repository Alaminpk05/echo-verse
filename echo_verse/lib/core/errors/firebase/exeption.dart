import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthExceptionHandler {
  static String getErrorMessage(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This user has been disabled. Please contact support.';
      case 'user-not-found':
        return 'No user found with this email. Please sign up first.';
      case 'wrong-password':
        return 'The password is incorrect. Please try again.';
      case 'email-already-in-use':
        return 'This email is already in use. Please use a different email.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled. Contact support.';
      case 'weak-password':
        return 'The password provided is too weak. Please use a stronger password.';
      case 'too-many-requests':
        return 'Too many login attempts. Please try again later.';
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }

  static String handleException(dynamic e) {
    if (e is FirebaseAuthException) {
      return getErrorMessage(e);
    }
    return 'An unknown error occurred. Please try again.';
  }
}
