import 'package:flutter/material.dart';
import 'package:imgur/app/barrel.dart';
import 'package:imgur/models/comments_models.dart';
import 'package:imgur/ui/widgets/video_thumbnail.dart';

class SingleFeedView extends StatelessWidget {
  final FeedModel feed;
  const SingleFeedView({Key? key, required this.feed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 15,
            ),
            Column(
              children: [
                Text("${feed.title}",
                    style: TextStyle(
                        fontSize: 20, overflow: TextOverflow.ellipsis)),
                Text("${feed.feedAuthor}"),
              ],
            )
          ],
        ),
        actions: [
          Icon(Icons.more_vert),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: feed.isAlbum
                ? ListView.builder(
                    itemCount: feed.images!.length,
                    itemBuilder: (context, index) {
                      final item = feed.images![index];
                      return itemView(
                          getContentType(item.type!, item.link!, item.height),
                          '${item.description}');
                    },
                  )
                : itemView(getContentType(feed.type!, feed.link!, feed.height),
                    '${feed.description}'),
          ),
          Expanded(

            child: Column(
              children: [
                Row(children: [
                  Icon(Icons.compare_arrows),
                  Text('BEST COMMENTS'),
                  Icon(Icons.comment),
                  Text('COMMENT')
                ],),
                Expanded(
                  child: ListView.builder(itemBuilder: (context, index) {
                    List<CommentsModel> comments = [];
                    final item = comments[index];
                    return Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Text('${item.author} . ${item.datetime}'),
                                Text('${item.commentCount}'),

                              ],
                            ),
                            Text('${item.comments}'),
                            Row(
                              children: [
                                Icon(Icons.thumb_up),
                                Text('${item.points}'),
                                Icon(Icons.thumb_down),
                                Text('Reply'),
                                Icon(Icons.more_horiz),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget itemView(Widget media, String description) {
    return Column(
      children: [
        media,
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(description, style: const TextStyle(color: Colors.white)),
        ),
      ],
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
