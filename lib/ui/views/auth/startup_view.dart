import 'package:flutter/material.dart';
import 'package:imgur/app/barrel.dart';
import 'package:imgur/data/controllers/authentication_controller.dart';
import 'package:imgur/ui/views/main_view.dart';
import 'package:provider/provider.dart';

class StartUpView extends StatefulWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  State<StartUpView> createState() => _StartUpViewState();
}

class _StartUpViewState extends State<StartUpView> {
  @override
  Future<void> didChangeDependencies() async {
    await _checkLogin();
    super.didChangeDependencies();
  }

  Future<void> _checkLogin() async {
    final auth = locator<AuthenticationController>();
    final _navigator = locator<NavigationService>();
    final status = await auth.getSignedIn();
    if (status) {
      _navigator.navigateTo(Routes.mainView);
    } else {
      _navigator.navigateTo(Routes.signup);
    }
  }

//TODO: add loading icon here
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final width = size.width;
    // final height = size.height;
    return Scaffold(
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
      
      ),
    );
  }
}
