import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:echo_verse/dependencies/service_locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

part 'check_internet_event.dart';
part 'check_internet_state.dart';

class InternetConnectionBloc
    extends Bloc<InternetConnectionEvent, InternetConnectionState> {
  final internetConnection = getIt<InternetConnection>();

  StreamSubscription? _subscription;
  InternetConnectionBloc() : super(InternetConnectionInitial()) {
    on<CheckInternetEvent>(_onCheckInternetEvent);
  }
  Future<void> _onCheckInternetEvent(
      CheckInternetEvent event, Emitter<InternetConnectionState> emit) async {
    final isConnected = await internetConnection.hasInternetAccess;
    if (isConnected) {
      debugPrint('INTERNET BLOC CONNECTION VARIABLE$isConnected');
      emit(InternetConnectedState());
    } else {
      emit(InternetDisconnectedState());
      debugPrint(internetConnectionBloc.state.toString());
      debugPrint(
          'INTERNET disconnected state BLOC CONNECTION VARIABLE$isConnected');
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
