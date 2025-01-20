import 'package:echo_verse/features/authentication/bloc/authentication_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          Text(FirebaseAuth.instance.currentUser!.uid.toString())
          ,Text(FirebaseAuth.instance.currentUser!.emailVerified.toString())
          
        ],
      ),
    );
  }
}
