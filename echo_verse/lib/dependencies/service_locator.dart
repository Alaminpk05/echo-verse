import 'package:echo_verse/core/routes/app_router.dart';
import 'package:echo_verse/core/services/objectbox/open_store.dart';
import 'package:echo_verse/features/authentication/data/repository/auth_contract.dart';
import 'package:echo_verse/features/authentication/data/repository/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  try {
    final objectBox = await ObjectBox.create();
    getIt.registerSingleton<ObjectBox>(objectBox);
    getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    getIt.registerLazySingleton<AuthContract>(() => AuthService());


    getIt.registerLazySingleton(() => AppRouter.router);
  } catch (e) {
    debugPrint("Error during dependency setup: $e");
    rethrow;
  }
}
