import 'package:chatchat/logic/auth/auth_cubit.dart';
import 'package:chatchat/logic/session_bloc.dart';
import 'package:chatchat/presentation/screen/activation/user_activation_view.dart';
import 'package:chatchat/presentation/screen/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth/auth_navigator.dart';

class SessionNavigator extends StatelessWidget {
  const SessionNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionBloc, SessionState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            if (state is SessionInitial 
              || state is LoginAttemptInitial
              || state is UserSignOutInitial)
              const MaterialPage(child: LoadingView()),

            if (state is LoginAttemptFailure)
              MaterialPage(
                child: BlocProvider(
                  create: (context) => AuthCubit(
                    sessionBloc: context.read<SessionBloc>()),
                  child: const AuthNavigator(),
                )
              ),
            
            if (state is LoginAttemptSuccess)
              const MaterialPage(
                child: UserActivationView()
              ),

            if (state is UserSignOutSuccess) 
              MaterialPage(
                child: BlocProvider(
                  create: (context) => AuthCubit(sessionBloc: context.read<SessionBloc>()),
                  child: const AuthNavigator(),
                )
              ),
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      }
    );
  }
}