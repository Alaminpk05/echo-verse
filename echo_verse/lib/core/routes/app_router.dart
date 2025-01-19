import 'package:echo_verse/core/routes/route_names.dart';
import 'package:echo_verse/features/authentication/bloc/authentication_bloc.dart';
import 'package:echo_verse/features/authentication/login/screens/login.dart';
import 'package:echo_verse/features/authentication/registration/screens/registration.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.home,
    redirect: (context, state) {
      final authState = context.read<AuthenticationBloc>().state;
      if (authState is AuthenticatedState) {
        return RouteNames.home;
      } else if (authState is UnAuthenticatedState) {
        return RouteNames.login;
      }
      return RouteNames.login;
    },
    routes: [
      GoRoute(path: RouteNames.login, builder: (context, state) => LoginPage()),
      GoRoute(
          path: RouteNames.signUp,
          builder: (context, state) => RegistrationPage()),
    ],
  );
}
