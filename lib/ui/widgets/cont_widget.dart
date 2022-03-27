import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imgur/app/barrel.dart';

import 'video_player.dart';
import 'video_thumbnail.dart';

Widget profilePicture(String name, {double radius= 18}) {
  return CircleAvatar(
    radius: radius,
    backgroundColor: appGreen,
    child: Text(name.substring(0, 1),
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
  );
}

bool isVideo(String type) => type.startsWith('video/');
bool isImage(String type) => type.startsWith('image/');
Widget getContentType(
  String type,
  String url,
  int height, {
  bool isItem = false,
  int width = 0,
}) {
  final imageHeight = 350.toDouble();

  if (isImage(type)) {
    return Image.network(
      url,
      fit: isItem ? null : BoxFit.cover,
      height: isItem ? null : imageHeight,
    );
  } else if (isVideo(type)) {
    return isItem
        ? CustomVideoPlayer(
            url: url,
            width: width.toDouble(),
            height: height.toDouble(),
          )
        : VideoThumbNailItem(
            url: url,
            height: imageHeight,
          );
  }
  return const SizedBox.shrink();
}
