import 'package:chatchat/logic/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInOptionsView extends StatefulWidget {
  const SignInOptionsView({Key? key}) : super(key: key);

  @override
  State<SignInOptionsView> createState() => _SignInOptionsViewState();
}

class _SignInOptionsViewState extends State<SignInOptionsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
              ),
              onPressed: () async => context.read<AuthCubit>().showSignInPage(),
              child: const Text('Email Login'),
            )
          ),
        ]
      )
    );
  }
}