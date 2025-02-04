import 'package:echo_verse/dependencies/service_locator.dart';
import 'package:echo_verse/features/authentication/bloc/authentication/authentication_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<AuthenticationBloc>().add(ManageUserInformationEvent());
    super.initState();
  }

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
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthenticatedState) {
                final userInfo = state.userInfoList.firstWhere(
                    (e) => e.email == firebaseAut.currentUser!.email);
                debugPrint('HERE PRINTED USE NAME');
                debugPrint(userInfo.name.toString());
                return Text(userInfo.name.toString());
              }
              return Text('nulll');
            },
          ),
          Text(FirebaseAuth.instance.currentUser!.email.toString()),
          Text(FirebaseAuth.instance.currentUser!.uid.toString()),
          Text(FirebaseAuth.instance.currentUser!.displayName.toString()),
          Text(FirebaseAuth.instance.currentUser!.emailVerified.toString()),
          TextButton(
              onPressed: () {
                // authServices.deleteAccount();
              },
              child: Text('Delete'))
        ],
      ),
    );
  }
}
