part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState extends Equatable {}

final class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

final class AuthenticationLoadingState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

final class AuthenticatedState extends AuthenticationState {
 

 

  @override
  List<Object?> get props => [];
}

final class UnAuthenticatedState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}
final class AccountDeltedState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

final class AuthenticationErrorState extends AuthenticationState {
  final String errorMessege;

  AuthenticationErrorState({required this.errorMessege});

  @override
  List<Object?> get props => [errorMessege];
}

final class AuthenticationIdleState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

final class SendEmailState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}
