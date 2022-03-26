import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imgur/app/appstate.dart';
import 'package:imgur/app/barrel.dart';
import 'package:imgur/app/config.dart';
import 'package:imgur/data/controllers/account_controller.dart';
import 'package:imgur/data/services/authentication_service.dart';
import 'package:imgur/data/services/shared_preferences.dart';
import 'package:imgur/models/ModelProvider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'state_controller.dart';

class AuthenticationController extends StateController
    with WidgetsBindingObserver {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final SharedPreferenceService _sharedPreferenceService =
      locator<SharedPreferenceService>();
  final AccountController _accountController = locator<AccountController>();

  //This is used to access the user data after the redirect to browser using kotlin methodchannel
  static const platform = MethodChannel('app.channel.shared.data');

  Map<String, dynamic> imguruserData = {};
  String? loginMethod;

  ///This parses the data gotten from the browser and logs in with amplify
  ///
  getAccessToken() async {
    if (imguruserData.isEmpty) {
      var sharedData = await platform.invokeMethod("getImgurResponse");
      if (sharedData != null) {
        imguruserData['access_token'] = sharedData['access_token'];
        imguruserData['refresh_token'] = sharedData['refresh_token'];
        imguruserData['id'] = sharedData['id'];
        imguruserData['username'] = sharedData['username'];
        imguruserData['expires_in'] = sharedData['expires_in'];

        log(imguruserData.toString());

        if (loginMethod != null) {
          if (loginMethod == "Google") {
            _signUpWithGoogle();
          } else if (loginMethod == "Facebook") {
            _signUpWithFacebook();
          }
        }
      }
    }
  }

  onReady() {
    WidgetsBinding.instance!.addObserver(this);
    getAccessToken();
  }

  ///Get code after callback from browser
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      getAccessToken();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  ///Url launcher is used because federated login(facebook and google) is disabled in embedded browser
  ///So if user isn't sign in with imgur they cant login with imgur's federated login
  Future<bool> _launchURL() async {
    final _url =
        'https://api.imgur.com/oauth2/authorize?client_id=$clientID&response_type=token';
    return await canLaunch(_url)
        ? await launch(_url)
        : throw 'Could not launch $_url';
  }

  Future<void> requestSignUp(
    String loginMethod,
  ) async {
    await _launchURL();
    this.loginMethod = loginMethod;
  }

  Future<void> _signUpWithGoogle() async {
    setAppState(AppState.busy);
    final result = await _authenticationService.signInUserWithGoogle();

    if (result != null) {
      _sharedPreferenceService.saveToken(imguruserData);
      _accountController.updateCurrentUser(result);
      _navigationService.navigateTo(Routes.mainView);
    }
    setAppState(AppState.idle);
  }

  Future<void> _signUpWithFacebook() async {
    setAppState(AppState.busy);
    final result = await _authenticationService.signInUserWithFacebook();

    if (result != null) {
      _sharedPreferenceService.saveToken(imguruserData);
      _accountController.updateCurrentUser(result);
      _navigationService.navigateTo(Routes.dashboard);
    }
    setAppState(AppState.idle);
  }

//Checks if the user is signed in and checks if accesstoken is still valid
  Future<bool> getSignedIn() async {
    UserModel? result = await _authenticationService.getCurrentUser();
    if (result != null) {
      log('User is signed in');
      final isValid = await _accountController.loadAccessTokenFromStorage();
      if (isValid) {
        log("User is signed in");
        _accountController.updateCurrentUser(result);
        return true;
      }
    }
    log("User is not signed in");
    return false;
  }
}
