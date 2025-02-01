part of 'check_internet_bloc.dart';

sealed class InternetConnectionState extends Equatable {
  const InternetConnectionState();

  @override
  List<Object> get props => [];
}

final class InternetConnectionInitial extends InternetConnectionState {}

final class InternetConnectedState extends InternetConnectionState{}
final class InternetDisconnectedState extends InternetConnectionState{}