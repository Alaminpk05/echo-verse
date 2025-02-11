part of 'settings_bloc.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

final class SettingsInitial extends SettingsState {}

final class SettingsLoadingState extends SettingsState {}

final class SettingsSuccessState extends SettingsState {}

final class SettingsErrorState extends SettingsState {
  final String errorMessege;

  const SettingsErrorState({required this.errorMessege});
}

final class SettingsIdleState extends SettingsState {}
final class SendNameState extends SettingsState {}
final class SendEmailState extends SettingsState {}
final class SendPasswordState extends SettingsState {}
final class AccountDeleteState extends SettingsState {}

