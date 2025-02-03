import 'package:bloc/bloc.dart';
import 'package:echo_verse/dependencies/service_locator.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    //on<AuthCheckStatusEvent>(_onAuthCheckStatusEvent);
    on<SignUpEvent>(_onSignUpEvent);
    on<LogInEvent>(_onLogInEvent);
    on<SignOutEvent>(_onSignOutEvent);
    on<PasswordResetEvent>(_onPasswordResetEvent);
  }

  Future<void> _onSignUpEvent(
      SignUpEvent event, Emitter<AuthenticationState> emit) async {
    final hasConnection = await internetConnection.hasInternetAccess;
    if (!hasConnection) {
      emit(AuthenticationIdleState());
      emit(AuthenticationErrorState(
          errorMessege:
              "No internet connection. Please check your network and try again."));
      debugPrint('EMITTED NO INTERNET AUTH ERROR STATE');
      return;
    }

    emit(AuthenticationLoadingState());
    try {
      final userCredential =
          await authServices.signUp(event.name, event.email, event.password);
      if (userCredential?.user != null) {
        final updatedUser = FirebaseAuth.instance.currentUser;

        emit(AuthenticatedState(
          user: updatedUser,
        ));
      } else {
        emit(AuthenticationIdleState());

        emit(AuthenticationErrorState(errorMessege: "User creation failed."));
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('SIGN UP MESSEGE:${e.message}');
      debugPrint('SIGH UP E CODE :${e.code}');
      emit(AuthenticationIdleState());
      emit(AuthenticationErrorState(
          errorMessege: firebaseAuthExceptionHandler.handleException(e)));
    } catch (e) {
      emit(AuthenticationIdleState());
      emit(AuthenticationErrorState(
          errorMessege: "An unknown error occurred. Please try again.}"));
      debugPrint('EMITTED ERROR STATE IN SIGN UP BLOC ${e.toString()}');
    }
  }

  Future<void> _onLogInEvent(
      LogInEvent event, Emitter<AuthenticationState> emit) async {
    final hasConnection = await internetConnection.hasInternetAccess;
    if (!hasConnection) {
      emit(AuthenticationIdleState());
      emit(AuthenticationErrorState(
          errorMessege:
              "No internet connection. Please check your network and try again."));

      debugPrint('EMITTED ERROR sTATE OF LOGIN EVENT INTERNET CONNECTION');
      return;
    }
    debugPrint('EMITTED LOADING STATE AND AUTHENTICATION BLOC');

    emit(AuthenticationLoadingState());
    try {
      final user = await authServices.login(event.email, event.password);
      if (user != null) {
        emit(AuthenticatedState(
          user: user,
        ));
        debugPrint(user.displayName);
      } else {
        emit(AuthenticationIdleState());
        emit(AuthenticationErrorState(
            errorMessege: "Login failed. Invalid credentials."));
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('CODE OF E PRINTED BELOW');
      debugPrint(e.code);
      debugPrint('CODE OF MESSEGE PRINTED BELOW');
      debugPrint(e.message);
      emit(AuthenticationIdleState());

      emit(AuthenticationErrorState(
          errorMessege: firebaseAuthExceptionHandler.handleException(e)));
      debugPrint(e.code.toString());
    } catch (e) {
      emit(AuthenticationIdleState());
      emit(AuthenticationErrorState(
          errorMessege: "An unknown error occurred. Please try again."));
      debugPrint("EMITTED LOGIN CATCH BLOC STATE ${e.toString()}");
    }
  }

  Future<void> _onSignOutEvent(
      SignOutEvent event, Emitter<AuthenticationState> emit) async {
    final hasConnection = await internetConnection.hasInternetAccess;
    if (!hasConnection) {
      emit(AuthenticationIdleState());
      emit(AuthenticationErrorState(
          errorMessege:
              "No internet connection. Please check your network and try again."));
      return;
    }
    emit(AuthenticationLoadingState());

    try {
      await authServices.signOut();
      emit(UnAuthenticatedState());
    } on FirebaseAuthException catch (e) {
      emit(AuthenticationIdleState());
      emit(AuthenticationErrorState(
          errorMessege: firebaseAuthExceptionHandler.handleException(e)));
    } catch (e) {
      emit(AuthenticationIdleState());
      emit(AuthenticationErrorState(
          errorMessege:
              "An error occurred while signing out. Please try again."));
    }
  }
}

Future<void> _onPasswordResetEvent(
    PasswordResetEvent event, Emitter<AuthenticationState> emit) async {
  final hasConnection = await internetConnection.hasInternetAccess;
  if (!hasConnection) {
    emit(AuthenticationIdleState());
    emit(AuthenticationErrorState(
        errorMessege:
            "No internet connection. Please check your network and try again."));
    return;
  }
  try {
    await authServices.resetPassword(event.email);
    final updatedUser = FirebaseAuth.instance.currentUser;
    emit(AuthenticatedState(user: updatedUser));
  } on FirebaseAuthException catch (e) {
    emit(AuthenticationIdleState());
    emit(AuthenticationErrorState(
        errorMessege: firebaseAuthExceptionHandler.getErrorMessage(e)));
  } catch (e) {
    emit(AuthenticationIdleState());
    emit(AuthenticationErrorState(
        errorMessege:
            "An error occurred while signing out. Please try again."));
  }
}
