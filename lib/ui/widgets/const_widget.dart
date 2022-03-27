import 'package:flutter/material.dart';
import 'package:imgur/app/barrel.dart';

import 'video_player.dart';
import 'video_thumbnail.dart';

final allowedExtensions = [
  'jpg',
  'png',
  'gif',
  'jpeg',
  'webp',
  'WEBM',
  'MPG',
  'MP2',
  'MPEG',
  'MPE',
  'MPV',
  'OGG',
  'MP4',
  'M4P',
  'M4V',
  'AVI',
  'WMV',
  'MOV',
  'QT',
  'FLV',
  'SWF',
  'AVCHD'
];
Widget profilePicture(String name, {double radius = 18}) {
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
  int? height, {
  bool isItem = false,
  int width = 0,
}) {
  double newHeight = 0;
  if (height != null) {
    newHeight = (height > 250 ? height / 3.6 : 250).toDouble();
  } else {
    height = 250;
    newHeight = 250.0;
  }
  if (isImage(type)) {
    return Image.network(
      url,
      fit: isItem ? null : BoxFit.cover,
      height: isItem ? null : newHeight,
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
            height: newHeight,
          );
  }
  return const SizedBox.shrink();
}

getDateFromTimestamp(int timestamp) {
  final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return '${date.day}/${date.month}/${date.year}';
}

String readTimeStampDaysOnly(timeStamp) {
  var now = DateTime.now();
  final times = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
  final diff = now.difference(times);
  var time = '${diff.inDays}';
  if (diff.inSeconds <= 59) {
    time = '${diff.inSeconds} s';
  }
  if (diff.inMinutes <= 59) {
    time = '${diff.inMinutes} m';
  } else if (diff.inHours <= 24) {
    time = '${diff.inHours} h';
  } else if (diff.inDays <= 30) {
    time = '${diff.inDays} d';
  } else if (diff.inDays > 30) {
    final month = diff.inDays / 30;
    time = '$month mn';
  } else if (diff.inDays >= 365) {
    final year = diff.inDays / 365;
    time = '$year y';
  }
  return time;
}
