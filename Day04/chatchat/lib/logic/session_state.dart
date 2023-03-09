part of 'session_bloc.dart';

@immutable
abstract class SessionState {}

class SessionInitial extends SessionState {}

class LoginAttemptInitial extends SessionState {}

class LoginAttemptFailure extends SessionState {
  final String errorMessage;
  LoginAttemptFailure({required this.errorMessage});
}

class LoginAttemptSuccess extends SessionState {
  final UserInfo user;

  LoginAttemptSuccess({required this.user});
}

class UserSignOutInitial extends SessionState {}

class UserSignOutSuccess extends SessionState {}

class UserSignOutFailure extends SessionState {
  final String errorMessage;
  UserSignOutFailure({required this.errorMessage});
}