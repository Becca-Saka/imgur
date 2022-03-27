import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imgur/app/barrel.dart';
import 'package:imgur/data/controllers/authentication_controller.dart';

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
      _navigator.closeAndNavigateTo(Routes.mainView);
    } else {
      _navigator.closeAndNavigateTo(Routes.signup);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/splash_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SizedBox(
            height: height / 4,
            width: width / 2,
            child: SvgPicture.asset(
              'assets/images/imgur-logo-white.svg',
              color: Colors.white,
              colorBlendMode: BlendMode.modulate,
            ),
          ),
        ),
      ),
    );
  }
}
