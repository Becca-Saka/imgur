import 'package:flutter/material.dart';
import 'package:imgur/app/barrel.dart';
import 'package:imgur/models/comments_models.dart';
import 'package:imgur/ui/widgets/video_player.dart';

class SingleFeedView extends StatelessWidget {
  final FeedModel feed;
  const SingleFeedView({Key? key, required this.feed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<FeedController>(
        onModelReady: (model) => model.getComments(feed.id),
        builder: (context, controller, child) {
          return Scaffold(
            backgroundColor: appDeepBlack,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      physics: const ScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildAppBar(context),
                          const SizedBox(height: 20),
                          _buildFeedContent(),
                          const SizedBox(height: 20),
                          feed.views != null
                              ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${feed.views} views',
                                    style: TextStyle(
                                        fontSize:12, color: appLightGrey)),
                              )
                              : const SizedBox.shrink(),
                          _buildCommentSection(controller),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: appDeepBlack.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.arrow_back),
                              color: Colors.white),
                        ),
                        _buildButtomBar(context)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Padding _buildButtomBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: appBlack,
        elevation: 30,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: appBlack,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_upward_outlined),
                color: Colors.white,
              ),
              Column(
                children: [
                  Icon(Icons.expand_less, color: appLightGrey),
                  const Text('113',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_downward_outlined),
                color: Colors.white,
              ),
              const Icon(Icons.favorite_border, color: Colors.white),
              const Icon(Icons.share_outlined, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }

  ColoredBox _buildCommentSection(FeedController controller) {
    return ColoredBox(
      color: appBlack,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(top: 12),
            child: Row(
              children: [
                Icon(
                  Icons.compare_arrows,
                  color: appLightGrey,
                  size: 16,
                ),
                const SizedBox(width: 5),
                Text('BEST COMMENTS',
                    style: TextStyle(fontSize: 14, color: appLightGrey)),
                const Spacer(),
                const Icon(
                  Icons.comment,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 5),
                const Text('COMMENT',
                    style: TextStyle(fontSize: 14, color: Colors.white))
              ],
            ),
          ),
          controller.comments.isNotEmpty
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.comments.length,
                  itemBuilder: (context, index) {
                    final item = controller.comments[index];
                    return CommentFeedItem(item: item);
                  })
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Row _buildAppBar(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
            color: Colors.white),
        const CircleAvatar(
          radius: 15,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${feed.title}",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("${feed.feedAuthor} ",
                      style: TextStyle(fontSize: 16, color: appLightGrey)),
                  Icon(
                    Icons.add_circle,
                    color: appLightGrey,
                    size: 15,
                  ),
                  const Spacer(),
                  Text('3h',
                      style: TextStyle(fontSize: 16, color: appLightGrey)),
                ],
              ),
            ],
          ),
        ),
        const Icon(Icons.more_vert, color: Colors.white),
      ],
    );
  }

  Widget _buildFeedContent() {
    return feed.isAlbum
        ? ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            // primary: false,
            shrinkWrap: true,
            itemCount: feed.images!.length,
            itemBuilder: (context, index) {
              final item = feed.images![index];
              return itemView(
                  getContentType(
                      item.type!, item.link!, item.height, item.width),
                  item.description);
            },
          )
        : itemView(
            getContentType(feed.type!, feed.link!, feed.height, feed.width),
            '${feed.description}');
  }

  Widget itemView(Widget media, String? description) {
    return Column(
      children: [
        media,
        description != null && description != 'null'
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(description,
                    style: const TextStyle(color: Colors.white)),
              )
            : const SizedBox.shrink(),
        const SizedBox(height: 10),
      ],
    );
  }

  bool isVideo(String type) => type.startsWith('video/');
  bool isImage(String type) => type.startsWith('image/');

  Widget getContentType(String type, String url, int height, int width) {
    if (isImage(type)) {
      return Image.network(
        url,
      );
    } else if (isVideo(type)) {
      return CustomVideoPlayer(
        url: url,
        width: width.toDouble(),
        height: height.toDouble(),
      );
    }
    return const SizedBox.shrink();
  }
}

class CommentFeedItem extends StatelessWidget {
  const CommentFeedItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final CommentsModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 15,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(item.author,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: appLightGrey)),
                        Text(' . 3h',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: appLightGrey)),
                        const Spacer(),
                        // Text(
                        //     '${item.author} . ${item.datetime}'),
                        Visibility(
                          visible: item.commentCount > 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: appDeepBlack,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text('${item.commentCount} replies',
                                style: const TextStyle(
                                    fontSize: 13,
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Text(item.comment,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                    Container(
                      margin: const EdgeInsets.only(right: 80),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.arrow_upward_outlined,
                            color: appLightGrey,
                          ),
                          Text('${item.points}',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: appLightGrey)),
                          Icon(Icons.arrow_downward_outlined,
                              color: appLightGrey),
                          Text('Reply',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: appLightGrey)),
                          Icon(Icons.more_horiz, color: appLightGrey)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: appDeepBlack,
          thickness: 1,
        ),
      ],
    );
  }
}
