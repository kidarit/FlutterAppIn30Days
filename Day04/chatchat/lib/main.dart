import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'amplifyconfiguration.dart';
import 'data/auth/auth_repository.dart';
import 'logic/session_bloc.dart';
import 'presentation/router/session_navigator.dart';
import 'presentation/screen/loading_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isAmplifyConfigured = false;
  
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugin(auth);
      await Amplify.configure(amplifyconfig);
      setState(() => _isAmplifyConfigured = true);
    } on Exception catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _isAmplifyConfigured
        ?  MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (context) => AuthRepository())
          ],
          child: BlocProvider(
            create: (context) => SessionBloc(
              authRepo: context.read<AuthRepository>(),
            )..add(UserLoginInitiated()),
            child: const SessionNavigator(),
          ),
        )
      : const LoadingView());
  }
}