import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: RadialGradient(
              center:   Alignment.topLeft,
              radius:   0.97,
                colors: [
              Color(0xFF291765),
              Color(0xFF34373C),
            ])),
        child: 
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset('assets/images/appiconwhite.svg',
                    height: 30, width: 30,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
