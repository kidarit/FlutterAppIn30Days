import 'package:chatchat/data/auth/auth_repository.dart';
import 'package:chatchat/data/auth/login_data.dart';
import 'package:chatchat/data/auth/user_info.dart';
import 'package:chatchat/logic/session_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final authRepo = AuthRepository();
  final SessionBloc sessionBloc;
  AuthCubit({required this.sessionBloc}) : super(AuthInitial());

  Future<void> showSignInPage() async {
    emit(SignInInitial());
  }

  showSignUpPage() {
    emit(SignUpInitial());
  }

  Future<UserInfo> signIn(LoginData loginData) async {
    final userInfo = await authRepo.signIn(loginData.email, loginData.password);
    sessionBloc.add(UserLoggedIn(userInfo: userInfo));

    return userInfo;
  }

  Future<void> signUp(LoginData loginData) async {
    await authRepo.signUp(loginData);

    emit(UserSignUpVerificationPending(loginData: loginData));
  }

  Future<void> confirmSignUp({required String email, required String code}) async {
    final result = await authRepo.confirmSignUp(email, code);

    if (result.isSignUpComplete) {
        emit(SignUpSuccess());
    } 
  }
}
