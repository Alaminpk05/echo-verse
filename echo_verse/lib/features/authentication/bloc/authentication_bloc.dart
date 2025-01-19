import 'package:bloc/bloc.dart';
import 'package:echo_verse/features/authentication/data/model/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    // on<AppStartedEvent>();
  }
}
