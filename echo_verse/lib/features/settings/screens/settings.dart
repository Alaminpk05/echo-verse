import 'package:echo_verse/core/constant/const_string.dart';
import 'package:echo_verse/core/routes/route_names.dart';
import 'package:echo_verse/dependencies/service_locator.dart';
import 'package:echo_verse/features/authentication/bloc/authentication/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Text(
                firebaseAut.currentUser!.displayName!,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
               SizedBox(
                height: 3.h,
              ),
              TextButton(
                  onPressed: () {
                    context.read<AuthenticationBloc>().add(SignOutEvent());
                  },
                  child: Text('Sign out')),
              SizedBox(
                height: 3.h,
              ),
              TextButton(
                  onPressed: () {
                    context.push(RoutePath.forget, extra: accountDelete);
                  },
                  child: Text('Delete'))
            ],
          ),
        ),
      ),
    );
  }
}
