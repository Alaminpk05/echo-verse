import 'package:echo_verse/core/constant/const_string.dart';
import 'package:echo_verse/core/routes/route_names.dart';
import 'package:echo_verse/features/authentication/bloc/authentication/authentication_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          Center(
            child: TextButton(
                onPressed: () {
                  context.read<AuthenticationBloc>().add(SignOutEvent());
                },
                child: Text('Sign out')),
          ),
          Text(FirebaseAuth.instance.currentUser!.displayName.toString()),
          Text(FirebaseAuth.instance.currentUser!.email.toString()),
          Text(FirebaseAuth.instance.currentUser!.uid.toString()),
          TextButton(
              onPressed: () {
                
                context.push(RoutePath.forget,extra: accountDelete);
              },
              child: Text('Delete'))
        ],
      ),
    );
  }
}
