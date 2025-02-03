import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthExceptionHandler {
  String getErrorMessage(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'invalid-credential':
        return 'No user found with this email. Please sign up first.';
      case 'user-disabled':
        return 'This user has been disabled. Please contact support.';
      case 'user-not-found':
        return 'No user found with this email. Please sign up first.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection and try again.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Please contact support.';
      case 'wrong-password':
        return 'The password is incorrect. Please try again.';
      case 'email-already-in-use':
        return 'This email is already in use. Please use a different email.';
      case 'weak-password':
        return 'The password provided is too weak. Please use a stronger password.';
      case 'too-many-requests':
        return 'Too many login attempts. Please try again later.';
      case 'quota-exceeded':
        return ('Daily email limit exceeded. Try again later.');
      case 'expired-action-code':
        return ('The reset password link has expired. Request a new one.');
      case 'invalid-action-code':
        return ('The reset password link is invalid or has already been used.');
      case 'captcha-check-failed':
        return ('Failed captcha verification. Please try again.');

      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }

  String handleException(dynamic e) {
    if (e is FirebaseAuthException) {
      return getErrorMessage(e);
    }
    return 'An unknown error occurred. Please try again.';
  }
}
