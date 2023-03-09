import 'package:chatchat/data/auth/login_data.dart';
import 'package:chatchat/logic/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final passwordConfirmTextController = TextEditingController();

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    passwordConfirmTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: emailTextController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: passwordTextController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: passwordConfirmTextController,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                ),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
              ),
              onPressed: () async => _createAccount(context),
              child: const Text('Sign Up'),
            ),
            const SizedBox(height: 30,),
            GestureDetector(
              onTap: () async => context.read<AuthCubit>().showSignInPage(),
              child: const Center(
                child: Text('Back to Sign In', style: TextStyle(fontWeight: FontWeight.bold))),
            ),
          ]
        )
      )
    );
  }

  Future<void> _createAccount(BuildContext context) async {
    if (emailTextController.text.isNotEmpty 
      && passwordConfirmTextController.text.isNotEmpty 
      && passwordConfirmTextController.text == passwordTextController.text) {

      final loginData = LoginData.from(email: emailTextController.text, password: passwordTextController.text);
      try {
        await context.read<AuthCubit>().signUp(loginData);
      } on Exception catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.black,
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
    }
  }
}