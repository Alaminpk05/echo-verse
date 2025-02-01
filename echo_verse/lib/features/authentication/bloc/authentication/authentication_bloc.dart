import 'package:bloc/bloc.dart';
import 'package:echo_verse/dependencies/service_locator.dart';
import 'package:echo_verse/features/authentication/bloc/CheckInternetConnection/check_internet_bloc.dart';
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
  }

  Future<void> _onSignUpEvent(
      SignUpEvent event, Emitter<AuthenticationState> emit) async {
    internetConnectionBloc.add(CheckInternetEvent());

    // Wait for the next state update
    final internetState = await internetConnectionBloc.stream.firstWhere(
      (state) =>
          state is InternetConnectedState || state is InternetDisconnectedState,
    );
    if (internetState is InternetDisconnectedState) {
      debugPrint('INTERNET BLOC CONNECTION ${internetConnectionBloc.state},');

      emit(AuthenticationErrorState(errorMessege: 'No internet connection'));
      debugPrint('EMITTED ERROR sTATE OF SIGNUP EVENT INTERNET CONNECTION');

      return;
    }
    debugPrint('INTERNET Disconnected BLOC NOT CALLED');

    emit(AuthenticationLoadingState());
    try {
      final userCredential =
          await authServices.signUp(event.name, event.email, event.password);
      if (userCredential?.user != null) {
        emit(AuthenticatedState(
          user: userCredential!.user!,
        ));
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
      debugPrint('EMITTED ERROR STATE IN SIGN UP BLOC ${e.toString()}');
    }
  }

  Future<void> _onLogInEvent(
      LogInEvent event, Emitter<AuthenticationState> emit) async {
    internetConnectionBloc.add(CheckInternetEvent());
     final internetState = await internetConnectionBloc.stream.firstWhere(
      (state) =>
          state is InternetConnectedState || state is InternetDisconnectedState,
    );
    if (internetState is InternetDisconnectedState) {
      emit(AuthenticationErrorState(errorMessege: 'No internet connection'));
      debugPrint('=>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
      debugPrint('EMITTED ERROR sTATE OF LOGIN EVENT INTERNET CONNECTION');
      debugPrint(internetConnectionBloc.state.toString());
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
        emit(AuthenticationErrorState(
            errorMessege: "Login failed. Invalid credentials."));
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);

      emit(AuthenticationErrorState(
          errorMessege: firebaseAuthExceptionHandler.handleException(e)));
      debugPrint(e.code.toString());
    } catch (e) {
      emit(AuthenticationErrorState(
          errorMessege: "An unknown error occurred. Please try again."));
      debugPrint("EMITTED LOGIN CATCH BLOC STATE ${e.toString()}");
    }
  }

  Future<void> _onSignOutEvent(
      SignOutEvent event, Emitter<AuthenticationState> emit) async {
    internetConnectionBloc.add(CheckInternetEvent());
    await Future.delayed(Duration.zero);
    if (internetConnectionBloc.state is InternetDisconnectedState) {
      emit(AuthenticationErrorState(errorMessege: 'No internet connection'));
      return;
    }
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
}
