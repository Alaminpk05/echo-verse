part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

final class PasswordResetEvent extends SettingsEvent {
  final String email;

  const PasswordResetEvent({required this.email});
}

final class ChangeNameEvent extends SettingsEvent {
  final String name;

  const ChangeNameEvent({required this.name});
}

final class ChangeEmailEvent extends SettingsEvent {
  final String email;
  final String password;

  const ChangeEmailEvent({ required this.password,  required this.email});
}

final class ChangePasswordEvent extends SettingsEvent {
  final String currentPassword;
  final String password;

  const ChangePasswordEvent({ required this.currentPassword, required this.password});
}

final class DeleteAccountEvent extends SettingsEvent {
  final String password;

  const DeleteAccountEvent({required this.password});
}
