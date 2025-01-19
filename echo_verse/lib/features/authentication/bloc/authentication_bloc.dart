import 'package:bloc/bloc.dart';
import 'package:echo_verse/features/authentication/data/repository/auth_contract.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthContract authService;
  AuthenticationBloc(this.authService) : super(AuthenticationInitial()) {
    on<AuthCheckStatusEvent>(_onAuthCheckStatusEvent);
    on<SignUpEvent>(_onSignUpEvent);
    on<LogInEvent>(_onLogInEvent);
    on<SignOutEvent>(_onSignOutEvent);
  }

  Future<void> _onAuthCheckStatusEvent(
      AuthCheckStatusEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoadingState());
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      emit(AuthenticatedState(user: user));
    } else {
      emit(UnAuthenticatedState());
    }
  }

  Future<void> _onSignUpEvent(
      SignUpEvent event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoadingState());
    try {
      final userCredential =
          await authService.signUp(event.name, event.email, event.password);
      if (userCredential?.user != null) {
        emit(AuthenticatedState(user: userCredential!.user!));
      } else {
        emit(AuthenticationErrorState(errorMessege: "User creation failed."));
      }
    } catch (e) {
      emit(AuthenticationErrorState(
          errorMessege: "Sign-up failed: ${e.toString()}"));
      debugPrint('EMITTED ERROR STATE IN SIGN UP BLOC');
    }
  }

  Future<void> _onLogInEvent(
      LogInEvent event, Emitter<AuthenticationState> emit) async {
    try {
      final user = await authService.login(event.email, event.password);
      if (user != null) {
        emit(AuthenticatedState(user: user));
      } else {
        emit(AuthenticationErrorState(
            errorMessege: "Login failed. Invalid credentials."));
      }
    } catch (e) {
      emit(AuthenticationErrorState(
          errorMessege: "Login failed: ${e.toString()}"));
    }
  }

  Future<void> _onSignOutEvent(
      SignOutEvent event, Emitter<AuthenticationState> emit) async {
    try {
      await authService.signOut();
      emit(UnAuthenticatedState());
    } catch (e) {
      emit(AuthenticationErrorState(
          errorMessege: "Sign-out failed: ${e.toString()}"));
    }
  }
}
