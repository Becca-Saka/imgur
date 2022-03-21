
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'random_colored_widget.dart';

class VideoThumbNailItem extends StatefulWidget {
  final String url;
  final double height;
  const VideoThumbNailItem({
    Key? key,
    required this.url,
    required this.height,
  }) : super(key: key);

  @override
  State<VideoThumbNailItem> createState() => _VideoThumbNailItemState();
}

class _VideoThumbNailItemState extends State<VideoThumbNailItem> {
  Uint8List? uint8list;
  @override
  void initState() {
    getThumb();
    super.initState();
  }

  getThumb() async {
    uint8list = await VideoThumbnail.thumbnailData(
      video: widget.url,
      imageFormat: ImageFormat.JPEG,
      maxWidth:
          128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 25,
    );
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: uint8list != null
          ? Image.memory(
              uint8list!,
              fit: BoxFit.cover,
            )
          : const RandomColorWidget(),
    );
  }
}