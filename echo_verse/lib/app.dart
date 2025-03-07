import 'package:echo_verse/core/routes/app_router.dart';
import 'package:echo_verse/core/config/theme/theme.dart';
import 'package:echo_verse/features/authentication/bloc/authentication/authentication_bloc.dart';
import 'package:echo_verse/features/settings/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key,});

  

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MultiBlocProvider(
          providers: [
             BlocProvider(
                create: (context) => AuthenticationBloc()
                  ),
             BlocProvider(
                create: (context) => SettingsBloc()
                  ),
            
           
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
