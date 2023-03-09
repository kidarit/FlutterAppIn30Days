import 'package:chatchat/data/auth/login_data.dart';
import 'package:chatchat/logic/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
              ),
              onPressed: () async => await _signIn(context),
              child: const Text('Sign In'),
            ),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account? ',), 
                GestureDetector(
                  onTap: () => context.read<AuthCubit>().showSignUpPage(),
                  child: const Center(
                    child: Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold),)),
                ),
              ],
            ),
          ]
        )
      )
    );
  }
  
  Future<void> _signIn(BuildContext context) async {
    if (emailTextController.text.isNotEmpty 
      && passwordTextController.text.isNotEmpty) {

      final loginData = LoginData.from(
        email: emailTextController.text, 
        password: passwordTextController.text);

      try {
        await context.read<AuthCubit>().signIn(loginData);
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