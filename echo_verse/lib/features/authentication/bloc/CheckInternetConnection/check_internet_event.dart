part of 'check_internet_bloc.dart';

sealed class InternetConnectionEvent extends Equatable {
  const InternetConnectionEvent();

  @override
  List<Object> get props => [];
}
 class CheckInternetEvent extends InternetConnectionEvent{
 }

