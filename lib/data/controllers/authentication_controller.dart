import 'dart:developer';
import 'package:imgur/app/appstate.dart';
import 'package:imgur/app/barrel.dart';
import 'package:imgur/data/controllers/account_controller.dart';
import 'package:imgur/data/services/authentication_service.dart';
import 'state_controller.dart';

class AuthenticationController extends StateController {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future<void> signUpWithGoogle() async {
    setAppState(AppState.busy);
    final result = await _authenticationService.signInUserWithGoogle();
    log('result: $result');
    if (result != null) {
     locator<AccountController>().updateCurrentUser(result);
      _navigationService.navigateTo(Routes.dashboard);
    }
    setAppState(AppState.idle);
  }

  Future<void> signUpWithFacebook() async {
    setAppState(AppState.busy);
    final result = await _authenticationService.signInUserWithFacebook();
    log('result: $result');
    if (result != null) {
     locator<AccountController>().updateCurrentUser(result);
      _navigationService.navigateTo(Routes.dashboard);
    }
    setAppState(AppState.idle);
  }
}
