part of 'session_bloc.dart';

@immutable
abstract class SessionEvent {}

class UserLoginInitiated extends SessionEvent {}

class UserLoggedIn extends SessionEvent {
  final UserInfo userInfo;
  UserLoggedIn({required this.userInfo});
}

class SignOutButtonClicked extends SessionEvent {}
