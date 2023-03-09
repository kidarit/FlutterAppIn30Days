part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class SignInInitial extends AuthState {}

class SignUpInitial extends AuthState {}

class SignUpSuccess extends AuthState {}

class UserSignUpVerificationPending extends AuthState {
  final LoginData loginData;
  UserSignUpVerificationPending({required this.loginData});
}
