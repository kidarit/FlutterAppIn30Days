import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'login_data.dart';
import 'user_info.dart';


class AuthRepository {

  Future<UserInfo?> attemptAutoLogin() async {
    final session = await Amplify.Auth.fetchAuthSession();
    if (session.isSignedIn) {
      return await _getUserIdFromAttributes();
    } else {
      throw Exception('Not signed in');
    }
  }

  Future<UserInfo> _getUserIdFromAttributes() async {
    final attributes = await Amplify.Auth.fetchUserAttributes();
    final subAttribute = attributes
      .firstWhere((element) => element.userAttributeKey.key == 'sub');
    final emailAttribute = attributes
      .firstWhere((element) => element.userAttributeKey.key == 'email');
    
    final userId = subAttribute.value;
    final email = emailAttribute.value;

    return UserInfo(email: email, userId: userId);
  }

  Future<void> signUp(LoginData loginData) async {
    try {
      await Amplify.Auth.signUp(
        username: loginData.email, 
        password: loginData.password,
        options: CognitoSignUpOptions(
          userAttributes: {
            CognitoUserAttributeKey.email: loginData.email
          }
        )
      );
    } on AuthException catch (e) {
      safePrint(e.message);
      rethrow;
    }
  }

  Future<SignUpResult> confirmSignUp(String email, String code) async {
    try {
      final res = await Amplify.Auth.confirmSignUp(
        username: email,
        confirmationCode: code,
      );
      return res;
    } on AuthException catch (e) {
      safePrint(e.message);
      rethrow;
    }
  }

  Future<UserInfo> signIn(String email, String password) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: email,
        password: password,
      );

      return await _getUserIdFromAttributes();

    } on AuthException catch (e) {
      safePrint(e.message);
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await Amplify.Auth.signOut();  
    } on AuthException catch (e) {
      safePrint(e.message);
      rethrow;
    }
  }
}