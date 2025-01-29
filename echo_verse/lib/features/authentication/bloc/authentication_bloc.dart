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
    on<PasswordVisibilityEVent>(_onPasswordVisibilityEVent);
  }

  Future<void> _onSignUpEvent(
      SignUpEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoadingState());
    try {
      final userCredential =
          await authServices.signUp(event.name, event.email, event.password);
      if (userCredential?.user != null) {
        emit(AuthenticatedState(user: userCredential!.user!));
      } else {
        emit(AuthenticationErrorState(errorMessege: "User creation failed."));
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('SIGN UP MESSEGE:${e.message}');
      debugPrint('SIGH UP E CODE :${e.code}');

      emit(AuthenticationErrorState(
          errorMessege: firebaseAuthExceptionHandler.handleException(e)));
    } catch (e) {
      emit(AuthenticationErrorState(
          errorMessege: "An unknown error occurred. Please try again.}"));
      debugPrint('EMITTED ERROR STATE IN SIGN UP BLOC');
    }
  }

  Future<void> _onLogInEvent(
      LogInEvent event, Emitter<AuthenticationState> emit) async {
    try {
      final user = await authServices.login(event.email, event.password);
      if (user != null) {
        emit(AuthenticatedState(user: user));
        debugPrint(user.displayName);
      } else {
        emit(AuthenticationErrorState(
            errorMessege: "Login failed. Invalid credentials."));
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);

      emit(AuthenticationErrorState(
          errorMessege: firebaseAuthExceptionHandler.handleException(e)));
    } catch (e) {
      emit(AuthenticationErrorState(
          errorMessege: "An unknown error occurred. Please try again."));
    }
  }

  Future<void> _onSignOutEvent(
      SignOutEvent event, Emitter<AuthenticationState> emit) async {
    try {
      await authServices.signOut();
      emit(UnAuthenticatedState());
    } on FirebaseAuthException catch (e) {
      emit(AuthenticationErrorState(
          errorMessege: firebaseAuthExceptionHandler.handleException(e)));
    } catch (e) {
      emit(AuthenticationErrorState(
          errorMessege:
              "An error occurred while signing out. Please try again."));
    }
  }

  Future<void> _onPasswordVisibilityEVent(
      PasswordVisibilityEVent event, Emitter<AuthenticationState> emit) async {
   
      if (state is PasswordVisibilityState) {
        final currentState = state as PasswordVisibilityState;
        
        emit(PasswordVisibilityState(isVisibility: !currentState.isVisibility));
       
      } else {
        emit(PasswordVisibilityState(isVisibility: true));
        
      }
   
  }
}
