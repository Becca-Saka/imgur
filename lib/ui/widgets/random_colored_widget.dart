import 'dart:math';

import 'package:flutter/material.dart';

class RandomColorWidget extends StatelessWidget {
  const RandomColorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(color: randomColor());
  }

  Color randomColor() {
    Random random = Random();

    return Color.fromARGB(
        255, random.nextInt(256), random.nextInt(256), random.nextInt(256));
  }
}