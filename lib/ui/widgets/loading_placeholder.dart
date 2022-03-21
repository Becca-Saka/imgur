import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'random_colored_widget.dart';

class LoadingPlaceholder extends StatelessWidget {
  const LoadingPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      itemCount: 15,
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      itemBuilder: (context, index) {
        return Card(
          child: SizedBox(
              height: 200 + (Random().nextInt(100).toDouble() * 2),
              child: const RandomColorWidget()),
        );
      },
    );
  }
}
