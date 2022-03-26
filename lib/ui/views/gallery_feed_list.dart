import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:imgur/models/feed_model.dart';
import 'package:imgur/ui/shared/const_color.dart';
import 'package:imgur/ui/widgets/video_thumbnail.dart';
import 'dart:ui' as ui;

class GalleryFeedList extends StatelessWidget {
  final List<FeedModel> feeds;
  const GalleryFeedList({Key? key, required this.feeds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      itemCount: feeds.length,
      itemBuilder: (context, index) {
        final be = feeds[index];
        final Album? album = be.images != null && be.images!.isNotEmpty
            ? be.images!.firstWhere((element) => element.id == be.cover)
            : null;
        final String link = album != null ? album.link! : be.link!;
        final type = album != null ? album.type! : be.type!;
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/single_feed_view', arguments: be);
          },
          child: Card(
            color: appBlack,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    getContentType(type, link, be.height),
                    Padding(
                      padding: const EdgeInsets.all(8.0).copyWith(top: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text('${be.title}',
                              style: const TextStyle(color: Colors.white)),
                          const SizedBox(height: 10),
                          const Text('135',
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Visibility(
                    // visible: album != null ,
                    // && be.images!.length > 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: isVideo(type)
                          ? const Icon(
                              Icons.videocam,
                              color: Colors.white,
                            )
                          : Row(
                              children: [
                                Text('${be.images!.length}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      shadows: [
                                        Shadow(
                                            color: Colors.black.withOpacity(0.6),
                                            blurRadius: 25),
                                      ],
                                    )),
                                Card(
                                  elevation: 8,
                                  color: Colors.transparent,
                                  shadowColor: Colors.black.withOpacity(0.6),
                                  child: const Icon(
                                    Icons.content_copy,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool isVideo(String type) => type.startsWith('video/');
  bool isImage(String type) => type.startsWith('image/');

  Widget getContentType(String type, String url, int height) {
    final imageHeight = (height <= 350 ? height : 350).toDouble();

    if (isImage(type)) {
      return Image.network(
        url,
        fit: BoxFit.cover,
        height: imageHeight,
      );
    } else if (isVideo(type)) {
      return VideoThumbNailItem(
        url: url,
        height: imageHeight,
      );
    }
    return const SizedBox.shrink();
  }
}
