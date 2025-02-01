import 'package:echo_verse/core/routes/route_names.dart';
import 'package:echo_verse/features/authentication/bloc/authentication/authentication_bloc.dart';
import 'package:echo_verse/features/authentication/login/screens/login.dart';
import 'package:echo_verse/features/authentication/registration/screens/registration.dart';
import 'package:echo_verse/features/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.login,
    redirect: (BuildContext context, GoRouterState state) {
      final bool loggedIn = FirebaseAuth.instance.currentUser != null;
      final String location = state.matchedLocation;

      if (!loggedIn && location != RouteNames.login && location != RouteNames.signUp) {
        return RouteNames.login; 
      }

      if (loggedIn && (location == RouteNames.login || location == RouteNames.signUp)) {
        return RouteNames.home; // Redirect to home if authenticated
      }

      return null; // No redirection needed
    },
    refreshListenable: GoRouterRefreshStream(
      FirebaseAuth.instance.authStateChanges(),
    ),
    routes: [
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => BlocProvider(
          create: (_) => AuthenticationBloc(),
          child: LoginPage(),
        ),
      ),
      GoRoute(
        path: RouteNames.signUp,
        builder: (context, state) => BlocProvider(
          create: (_) => AuthenticationBloc(),
          child: RegistrationPage(),
        ),
      ),
      GoRoute(
        path: RouteNames.home,
        builder: (context, state) => HomePage(),
      ),
    ],
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<User?> authStateChanges) {
    authStateChanges.listen((_) => notifyListeners());
  }
}
