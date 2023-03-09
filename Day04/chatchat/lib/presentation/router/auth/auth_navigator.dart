
import 'package:chatchat/logic/auth/auth_cubit.dart';
import 'package:chatchat/presentation/screen/auth/sign_in_options_view.dart';
import 'package:chatchat/presentation/screen/auth/sign_in_view.dart';
import 'package:chatchat/presentation/screen/auth/sign_up_view.dart';
import 'package:chatchat/presentation/screen/auth/signup_confirmation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthNavigator extends StatelessWidget {
  const AuthNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Navigator(
        pages: [
          if (state is AuthInitial || state is SignUpSuccess)
            const MaterialPage(child: SignInOptionsView()),

          if (state is SignInInitial)
            const MaterialPage(child: SignInView()),
          
          if (state is SignUpInitial)
            const MaterialPage(child: SignUpView()), 
          
          if (state is UserSignUpVerificationPending) 
            MaterialPage(child: SignUpConfirmationView(loginData: state.loginData)),
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}