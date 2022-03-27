import 'dart:async';
import 'dart:developer';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:imgur/app/amplify_configure.dart';
import 'package:imgur/app/barrel.dart';

class AuthenticationService {
  final auth = Amplify.Auth;
  final dataStore = Amplify.DataStore;

  ///Get current loggedIn user
  Future<UserModel?> getCurrentUser() async {
    try {
      if (AmplifyConfiguration.instance.isSignedIn) {
        final user = await getUserFromDatabase();
        if (user != null) {
          return user;
        }
      }
    } catch (e) {
      log('Error $e');
      rethrow;
    }
    return null;
  }

  Future<UserModel?> getUserFromDatabase() async {
    try {
      final currentUser = await auth.getCurrentUser();
      final user = await dataStore.query(UserModel.classType,
          where: UserModel.ID.eq(currentUser.userId));
      if (user.isNotEmpty) {
        return user.first;
      }
      return null;
    } on Exception catch (e) {
      log('Error $e');
      return null;
    }
  }

  Future<UserModel?> signInUserWithGoogle() async {
    try {
      await auth.signOut();
      SignInResult result = await auth.signInWithWebUI(
        provider: AuthProvider.google,
      );
      if (result.isSignedIn) {
        List<AuthUserAttribute> authUserAttributes =
            await auth.fetchUserAttributes();
        String userId = authUserAttributes[0].value;
        String userName = authUserAttributes[3].value;
        String email = authUserAttributes[4].value;

        for (int i = 0; i < authUserAttributes.length; i++) {
          final key = authUserAttributes[i].userAttributeKey.toString();
          final value = authUserAttributes[i].value;
          if (key == "email") {
            email = value;
          } else if (key == "name") {
            userName = value;
          } else if (key == "sub") {
            userId = value;
          }
        }

        return await _handleAuthenticatedUser(userId, email, userName);
      }
    } on AmplifyException catch (e) {
      SnackBarService.showErrorSnackBar(getErrorMessage(e.message));
    } catch (e) {
      log('Error $e');
    }
    return null;
  }

  FutureOr<UserModel?> signInUserWithFacebook() async {
    try {
      await auth.signOut();
      SignInResult result = await auth.signInWithWebUI(
        provider: AuthProvider.facebook,
      );
      if (result.isSignedIn) {
        List<AuthUserAttribute> authUserAttributes =
            await auth.fetchUserAttributes();
        String userId = authUserAttributes[0].value;
        String userName = authUserAttributes[3].value;
        String email = authUserAttributes[4].value;
        for (int i = 0; i < authUserAttributes.length; i++) {
          final key = authUserAttributes[i].userAttributeKey.toString();
          final value = authUserAttributes[i].value;
          if (key == "email") {
            email = value;
          } else if (key == "name") {
            userName = value;
          } else if (key == "sub") {
            userId = value;
          }
        }

        return await _handleAuthenticatedUser(userId, email, userName);
      }
    } on AmplifyException catch (e) {
      SnackBarService.showErrorSnackBar(getErrorMessage(e.message));
    } catch (e) {
      log('Error $e');
    }
    return null;
  }

  Future<UserModel> _handleAuthenticatedUser(
    String userId,
    String email,
    String userName,
  ) async {
    List<UserModel> user = await dataStore.query(UserModel.classType,
        where: UserModel.ID.eq(userId));
    if (user.isNotEmpty) {
      return user.first;
    } else {
      return await _saveUserToDataBase(
        email,
        userName,
      );
    }
  }

  Future<UserModel> _saveUserToDataBase(
    String email,
    String userName,
  ) async {
    final currentUser = await Amplify.Auth.getCurrentUser();
    final user = UserModel(
      email: email,
      username: userName,
      id: currentUser.userId,
    );
    await dataStore.save(user);
    return user;
  }

  ///Getting [AmplifyException] error message and mapping it to a readable message
  String getErrorMessage(String error) {
    String message = "";

    switch (error) {
      case "Failed since user is not authorized.":
        message = "Incorrect username or password";

        break;
      case "User not found in the system.":
        message = "Account not found, please sign up";
        break;
      case "Username already exists in the system":
        message = "Email already exists, please sign in";
        break;
      default:
        "Something went wrong, please try again";
    }

    return message;
  }
}
