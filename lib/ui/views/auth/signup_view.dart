import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imgur/app/appstate.dart';
import 'package:imgur/app/barrel.dart';
import 'package:imgur/data/controllers/authentication_controller.dart';
import 'package:imgur/data/services/shared_preferences.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthenticationController>(
        onModelReady: (model) => model.onReady(),
        builder: (context, controller, child) {
          return Scaffold(
            body: IgnorePointer(
              ignoring: controller.state == AppState.busy,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          appBlue,
                          appGreen,
                        ])),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const Spacer(),
                          const Text('Discover the\n magic of the\n Internet',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 34,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(height: 40),
                          _socialAuthButtons(
                            'Continue with Google',
                            const Color(0xFF4267B2),
                            Colors.white,
                            () => controller.requestSignUp('Google'),
                            suffixIcon: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: Image.asset(
                                'assets/images/google.png',
                                height: 30,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          _socialAuthButtons(
                            'Continue with Facebook',
                            Colors.white,
                            appGreen,
                            () => controller.requestSignUp('Facebook'),
                            suffixIcon: Image.asset(
                              'assets/images/Facebook-01.jpg',
                              height: 38,
                            ),
                          ),
                          const Spacer(
                            flex: 3,
                          ),
                          SvgPicture.asset(
                            'assets/images/appiconwhite.svg',
                            color: Colors.white,
                            colorBlendMode: BlendMode.srcIn,
                            height: 25,
                            width: 25,
                          ),
                          const SizedBox(height: 20),
                          RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: 'By continuing, you agree to our ',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  children: [
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          SharedPreferenceService().readToken();
                                          // log('tapped');
                                        },
                                      text: 'Terms of Service',
                                      style: const TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const TextSpan(
                                      text: '\n and ',
                                    ),
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          log('tapped');
                                        },
                                      text: 'Privacy Policy',
                                      style: const TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const TextSpan(
                                      text: '. (CA residents: ',
                                    ),
                                    TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          log('tapped');
                                        },
                                      text: 'CCPA',
                                      style: const TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const TextSpan(
                                      text: ')',
                                    ),
                                  ])),
                          const SizedBox(height: 1),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: controller.state == AppState.busy,
                    child: Container(
                      color: Colors.grey.withOpacity(0.5),
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  SizedBox _socialAuthButtons(
      String name, Color color, Color textColor, Function() onTap,
      {required Widget suffixIcon}) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0.3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            primary: color),
        onPressed: onTap,
        child: Row(
          children: [
            suffixIcon,
            const SizedBox(width: 8),
            Expanded(
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(
                      fontSize: 18,
                      color: textColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
