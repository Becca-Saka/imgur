import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:imgur/data/models/feed_model.dart';
import 'package:imgur/ui/shared/const_color.dart';
import 'package:imgur/ui/views/home.dart';

class GalleryFeedList extends StatelessWidget {
  final List<FeedModel> feeds;
  const GalleryFeedList({Key? key, required this.feeds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MasonryGridView.count(
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
          return Card(
            color: appBlack,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                getContentType(type, link),
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
                          style: const TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  Widget getContentType(String type, String url) {
    if (type.startsWith('image/')) {
      return Image.network(url, fit: BoxFit.cover);
    } else if (type.startsWith('video/')) {
      return VideoItem(
        url: url,
      );
    }
    return Text('content $type');
  }
}
