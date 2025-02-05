part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

final class SignUpEvent extends AuthenticationEvent {
  final String name;
  final String email;
  final String password;

  SignUpEvent(
      {required this.name, required this.email, required this.password});
}

final class LogInEvent extends AuthenticationEvent {
  final String email;
  final String password;

  LogInEvent({required this.email, required this.password});
}

final class SignOutEvent extends AuthenticationEvent {}

final class PasswordResetEvent extends AuthenticationEvent {
  final String email;

  PasswordResetEvent({required this.email});
}

final class ManageUserInformationEvent extends AuthenticationEvent {}

final class DeleteAccount extends AuthenticationEvent {
 
  final String password;

  DeleteAccount({required this.password});
}
