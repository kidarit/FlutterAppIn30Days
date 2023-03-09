import 'package:chatchat/data/auth/login_data.dart';
import 'package:chatchat/logic/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpConfirmationView extends StatefulWidget {
  final LoginData loginData;
  const SignUpConfirmationView({Key? key, required this.loginData}) : super(key: key);

  @override
  State<SignUpConfirmationView> createState() => _SignUpConfirmationViewState();
}

class _SignUpConfirmationViewState extends State<SignUpConfirmationView> {
  final emailTextController = TextEditingController();
  final verificationCodeTextController = TextEditingController();

  @override
  void dispose() {
    emailTextController.dispose();
    verificationCodeTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification'),
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
                controller: verificationCodeTextController,
                decoration: const InputDecoration(
                  labelText: 'Verification Code',
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
              ),
              onPressed: () async => _confirmVerificationCode(context),
              child: const Text('Confirm'),
            ),
          ]
        )
      )
    );
  }

  Future<void> _confirmVerificationCode(BuildContext context) async {
    if (emailTextController.text.isNotEmpty 
      && verificationCodeTextController.text.isNotEmpty) {

      try {
        await context.read<AuthCubit>().confirmSignUp(
          email: emailTextController.text, 
          code: verificationCodeTextController.text);          
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