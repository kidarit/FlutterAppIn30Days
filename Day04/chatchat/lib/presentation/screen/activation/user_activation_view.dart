import 'package:chatchat/logic/auth/auth_cubit.dart';
import 'package:chatchat/logic/session_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserActivationView extends StatefulWidget {
  const UserActivationView({Key? key}) : super(key: key);

  @override
  State<UserActivationView> createState() => _UserActivationViewState();
}

class _UserActivationViewState extends State<UserActivationView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activation'),
      ),
      body: Column(children: [
        const Center(
          child: Text('You are logged in!')
        ),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0)),
          ),
          onPressed: () async => await _signOut(context),
          child: const Text('Sign Out'),
        ),
      ],)
    );
  }

  _signOut(BuildContext context) {
    context.read<SessionBloc>().add(SignOutButtonClicked());
  }
}