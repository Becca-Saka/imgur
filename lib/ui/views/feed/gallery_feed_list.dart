import 'package:flutter/material.dart';
import 'package:imgur/app/barrel.dart';
import 'package:imgur/models/feed_arguments.dart';

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
        ///Checks if the feed is an album or a single photo
        final be = feeds[index];
        final Album? album = be.images != null && be.images!.isNotEmpty
            ? be.images!.firstWhere((element) => element.id == be.cover)
            : null;
        final String link = album != null ? album.link! : be.link!;
        final type = album != null ? album.type! : be.type!;
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, Routes.singleFeedItem,
                arguments: FeedArgumnet(feed: be));
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
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(ImgurIconPack.upArrow,
                                  color: appLightGrey, size: 14),
                              const SizedBox(width: 4),
                              Text('${be.points} Points',
                                  style: TextStyle(color: appLightGrey)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Visibility(
                    visible: album != null,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: be.images != null && be.images!.length > 1
                            ? Row(
                                children: [
                                  Text('${be.images!.length}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        shadows: [
                                          Shadow(
                                              color:
                                                  Colors.black.withOpacity(0.8),
                                              blurRadius: 7),
                                        ],
                                      )),
                                  const SizedBox(width: 4),
                                  Container(
                                    width: 18,
                                    height: 18,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            blurRadius: 4),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.content_copy,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ],
                              )
                            : isVideo(type)
                                ? const Icon(
                                    Icons.videocam,
                                    color: Colors.white,
                                  )
                                : const SizedBox.shrink()),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
