import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:imgur/app/barrel.dart';
import 'package:imgur/models/ModelProvider.dart';

class AuthenticationService {
  final auth = Amplify.Auth;
  final dataStore = Amplify.DataStore;

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
        String picture = authUserAttributes[5].value;
        log('userId: $userId: userName: $userName email: $email picture: $picture');

        return await _handleAuthenticatedUser(userId, email, userName, picture);
      }
    } on AmplifyException catch (e) {
      SnackBarService.showErrorSnackBar(getErrorMessage(e.message));
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
        final pictureData = authUserAttributes[5].value;
        String? picture;
        if (pictureData.isNotEmpty) {
          final decodedPicture = jsonDecode(pictureData);
          picture = decodedPicture['data']['url'];
        }

        return await _handleAuthenticatedUser(userId, email, userName, picture);
      }
    } on AmplifyException catch (e) {
      SnackBarService.showErrorSnackBar(getErrorMessage(e.message));
    }
    return null;
  }

  Future<UserModel> _handleAuthenticatedUser(
      String userId, String email, String userName, String? picture) async {
    List<UserModel> user = await dataStore.query(UserModel.classType,
        where: UserModel.ID.eq(userId));
    if (user.isNotEmpty) {
      return user.first;
    } else {
      return await _saveUserToDataBase(
        email,
        userName,
        picture: picture,
      );
    }
  }

  Future<UserModel> _saveUserToDataBase(String email, String userName,
      {String? picture}) async {
    final currentUser = await Amplify.Auth.getCurrentUser();

    final user = UserModel(
      email: email,
      username: userName,
      picture: picture,
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
