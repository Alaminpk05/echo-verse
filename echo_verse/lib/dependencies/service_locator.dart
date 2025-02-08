import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:echo_verse/core/errors/firebase/exception.dart';
import 'package:echo_verse/core/routes/app_router.dart';
import 'package:echo_verse/core/services/objectbox/open_store.dart';
import 'package:echo_verse/core/utils/helpers/snackbar.dart';
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
    getIt.registerFactory<InternetConnection>(() => InternetConnection());
    getIt.registerSingleton<ObjectBox>(objectBox);
    getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
    getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
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

/// GLOBAL INSTANCE FOR ACCESSING ACROSS THE APP
InternetConnection get internetConnection => getIt<InternetConnection>();
ObjectBox get objectBox => getIt<ObjectBox>();
FirebaseAuth get firebaseAut => getIt<FirebaseAuth>();
FirebaseFirestore get firestore => getIt<FirebaseFirestore>();
User? get user => firebaseAut.currentUser!;
String? get userUid => user?.uid;
String? get userEmail => user?.email;
String? get userName => user?.displayName;
AuthContract get authServices => getIt<AuthContract>();
CustomSnackbar get customSnackBar => getIt<CustomSnackbar>();
AppRouter get appRouter => getIt<AppRouter>();

FirebaseAuthExceptionHandler get firebaseAuthExceptionHandler =>
    getIt<FirebaseAuthExceptionHandler>();
