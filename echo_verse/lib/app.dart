import 'package:echo_verse/core/routes/app_router.dart';
import 'package:echo_verse/core/config/theme/theme.dart';

import 'package:echo_verse/features/authentication/bloc/authentication_bloc.dart';
import 'package:echo_verse/features/authentication/data/repository/auth_contract.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.authContract});

  final AuthContract authContract;

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => AuthenticationBloc(authContract)
                  )
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Echo Verse',
            theme: AppTheme.lightTheme,
            routerConfig: AppRouter.router,
          ),
        );
      },
    );
  }
}
