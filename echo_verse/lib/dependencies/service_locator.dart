import 'package:echo_verse/core/errors/firebase/exception.dart';
import 'package:echo_verse/core/routes/app_router.dart';
import 'package:echo_verse/core/services/objectbox/open_store.dart';
import 'package:echo_verse/core/utils/helpers/snackbar.dart';
import 'package:echo_verse/features/authentication/bloc/CheckInternetConnection/check_internet_bloc.dart';
import 'package:echo_verse/features/authentication/data/repository/auth_contract.dart';
import 'package:echo_verse/features/authentication/data/repository/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

final getIt = GetIt.instance;


Future<void> setupServiceLocator() async {
  try {
    final objectBox = await ObjectBox.create();
    getIt.registerLazySingleton<InternetConnection>(()=>InternetConnection());
    getIt.registerFactory<InternetConnectionBloc>(()=>InternetConnectionBloc());
    getIt.registerSingleton<ObjectBox>(objectBox);
    getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    getIt.registerSingleton<AuthContract>(AuthService());
    

    getIt.registerLazySingleton<FirebaseAuthExceptionHandler>(
        () => FirebaseAuthExceptionHandler());

    getIt.registerLazySingleton<CustomSnackbar>(() => CustomSnackbar());

    getIt.registerLazySingleton(() => AppRouter.router);
  } catch (e) {
    debugPrint("Error during dependency setup: $e");
    rethrow;
  }
}

//// GLOBAL INSTANCE FOR ACCESSING ACROSS THE APP
InternetConnection get internetConnection => getIt<InternetConnection>();
InternetConnectionBloc get internetConnectionBloc =>
    getIt<InternetConnectionBloc>();
ObjectBox get objectBox => getIt<ObjectBox>();
FirebaseAuth get firebaseAut => getIt<FirebaseAuth>();
AuthContract get authServices => getIt<AuthContract>();
CustomSnackbar get customSnackBar => getIt<CustomSnackbar>();
AppRouter get appRouter => getIt<AppRouter>();
FirebaseAuthExceptionHandler get firebaseAuthExceptionHandler =>
    getIt<FirebaseAuthExceptionHandler>();
