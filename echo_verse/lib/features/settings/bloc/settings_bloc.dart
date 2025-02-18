import 'package:bloc/bloc.dart';
import 'package:echo_verse/dependencies/service_locator.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<PasswordResetEvent>(_onPasswordResetEvent);
    on<DeleteAccountEvent>(_onDeleteAccount);
    on<ChangeNameEvent>(_onChangeNameEvent);
    on<ChangeEmailEvent>(_onChangeEmailEvent);
    on<ChangePasswordEvent>(_onChangePasswordEvent);
    on<ChangeProfileImage>(_onChangeProfileImageEvent);
  }

  Future<void> _onChangeProfileImageEvent(
      ChangeProfileImage event, Emitter<SettingsState> emit) async {
    final hasConnection = await internetConnection.hasInternetAccess;
    if (!hasConnection) {
      emit(SettingsIdleState());
      emit(SettingsErrorState(
          errorMessege:
              "No internet connection. Please check your network and try again."));
      return;
    }
    emit(SettingsLoadingState());
    try {
      String? imageUrl;
      if (event.isChange) {
        imageUrl = await settingsServices.changeProfile();
      }

      emit(ChangeProfileImageState(image: imageUrl ?? user!.photoURL));
    } catch (e) {
      emit(SettingsErrorState(errorMessege: 'Profile picture change failed'));
    }
  }

  Future<void> _onChangeNameEvent(
      ChangeNameEvent event, Emitter<SettingsState> emit) async {
    final hasConnection = await internetConnection.hasInternetAccess;
    if (!hasConnection) {
      emit(SettingsIdleState());
      emit(SettingsErrorState(
          errorMessege:
              "No internet connection. Please check your network and try again."));
      return;
    }
    emit(SettingsLoadingState());
    try {
      debugPrint('Email change event called');
      User? updateUser = await settingsServices.changeName(event.name);
      debugPrint(updateUser.toString());

      emit(ChangeNameState(user: updateUser));
    } on FirebaseAuthException catch (e) {
      emit(SettingsIdleState());
      emit(SettingsErrorState(
          errorMessege: firebaseAuthExceptionHandler.getErrorMessage(e)));
    } catch (e) {
      emit(SettingsIdleState());
      emit(SettingsErrorState(
          errorMessege:
              "An error occurred while signing out. Please try again."));
    }
  }

  Future<void> _onChangeEmailEvent(
      ChangeEmailEvent event, Emitter<SettingsState> emit) async {
    final hasConnection = await internetConnection.hasInternetAccess;
    if (!hasConnection) {
      emit(SettingsIdleState());
      emit(SettingsErrorState(
          errorMessege:
              "No internet connection. Please check your network and try again."));
      return;
    }
    emit(SettingsLoadingState());

    try {
      await settingsServices.changeEmail(event.email, event.password);
      emit(EmailChangeState());
    } on FirebaseAuthException catch (e) {
      emit(SettingsIdleState());
      emit(SettingsErrorState(
          errorMessege: firebaseAuthExceptionHandler.getErrorMessage(e)));
    } catch (e) {
      emit(SettingsIdleState());
      emit(SettingsErrorState(
          errorMessege:
              "An error occurred while signing out. Please try again."));
    }
  }

  Future<void> _onChangePasswordEvent(
      ChangePasswordEvent event, Emitter<SettingsState> emit) async {
    final hasConnection = await internetConnection.hasInternetAccess;
    if (!hasConnection) {
      emit(SettingsIdleState());
      emit(SettingsErrorState(
          errorMessege:
              "No internet connection. Please check your network and try again."));
      return;
    }
    emit(SettingsLoadingState());
    try {
      await settingsServices.changePassword(
          event.password, event.currentPassword);
      emit(SettingsSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(SettingsIdleState());
      emit(SettingsErrorState(
          errorMessege: firebaseAuthExceptionHandler.getErrorMessage(e)));
    } catch (e) {
      emit(SettingsIdleState());
      emit(SettingsErrorState(
          errorMessege:
              "An error occurred while signing out. Please try again."));
    }
  }

  Future<void> _onPasswordResetEvent(
      PasswordResetEvent event, Emitter<SettingsState> emit) async {
    final hasConnection = await internetConnection.hasInternetAccess;
    if (!hasConnection) {
      emit(SettingsIdleState());
      emit(SettingsErrorState(
          errorMessege:
              "No internet connection. Please check your network and try again."));
      return;
    }
    emit(SettingsLoadingState());
    try {
      await authServices.resetPassword(event.email);

      emit(SendEmailState());
    } on FirebaseAuthException catch (e) {
      emit(SettingsIdleState());
      emit(SettingsErrorState(
          errorMessege: firebaseAuthExceptionHandler.getErrorMessage(e)));
    } catch (e) {
      emit(SettingsIdleState());
      emit(SettingsErrorState(
          errorMessege:
              "An error occurred while signing out. Please try again."));
    }
  }

  Future<void> _onDeleteAccount(
      DeleteAccountEvent event, Emitter<SettingsState> emit) async {
    emit(SettingsLoadingState());
    try {
      final email = firebaseAut.currentUser!.email!;
      await authServices.deleteAccount(email, event.password);
      emit(AccountDeleteState());
    } on FirebaseAuthException catch (e) {
      debugPrint('SIGN UP MESSEGE:${e.message}');
      debugPrint('SIGH UP E CODE :${e.code}');
      emit(SettingsIdleState());
      emit(SettingsErrorState(
          errorMessege: "Incorrect password. Please try again."));
    } catch (e) {
      emit(SettingsIdleState());
      emit(SettingsErrorState(
          errorMessege:
              "An error occurred while signing out. Please try again."));
    }
  }
}
