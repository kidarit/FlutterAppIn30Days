import 'package:chatchat/data/auth/auth_repository.dart';
import 'package:chatchat/data/auth/user_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'session_event.dart';
part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final AuthRepository authRepo;
  SessionBloc({
    required this.authRepo,
  }) : super(SessionInitial()) {

    on<UserLoginInitiated>((event, emit) async {
      emit(LoginAttemptInitial());
      try {
        final userInfo = await authRepo.attemptAutoLogin();
        emit(LoginAttemptSuccess(user: userInfo!));
      } on Exception catch (e) {
        emit(LoginAttemptFailure(errorMessage: e.toString()));
      }
    });

    on<UserLoggedIn>((event, emit) async {
      try {
        emit(LoginAttemptSuccess(user: event.userInfo));
      } on Exception catch (e) {
        emit(LoginAttemptFailure(errorMessage: e.toString()));
      }
    });

    on<SignOutButtonClicked>((event, emit) async {
      try {
        emit(UserSignOutInitial());
        await authRepo.signOut();
        
        emit(UserSignOutSuccess());
      } on Exception catch (e) {
        emit(UserSignOutFailure(errorMessage: e.toString()));
      }    
    });
  }
}
