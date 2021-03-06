import 'package:flutter/material.dart';
import 'package:imgur/app/barrel.dart';
import 'package:imgur/models/comments_models.dart';
import 'package:imgur/models/feed_arguments.dart';

class SingleFeedView extends StatelessWidget {
  final FeedArgumnet feedArgument;
  const SingleFeedView({
    Key? key,
    required this.feedArgument,
  }) : super(key: key);
  FeedModel get feed => feedArgument.feed;
  bool get isUserFeed => feedArgument.isUserFeed;
  @override
  Widget build(BuildContext context) {
    return BaseView<FeedController>(onModelReady: (model) {
      if (!isUserFeed) {
        model.getComments(feed.id);
      }
    }, builder: (context, controller, child) {
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
                      _buildAppBar(context, controller),
                      const SizedBox(height: 20),
                      _buildFeedContent(),
                      const SizedBox(height: 20),
                      Visibility(
                        visible: !isUserFeed,
                        child: feed.views != null
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${feed.views} views',
                                    style: TextStyle(
                                        fontSize: 12, color: appLightGrey)),
                              )
                            : const SizedBox.shrink(),
                      ),
                      Visibility(
                          visible: !isUserFeed,
                          replacement: _commentTopBar(controller),
                          child: _buildCommentSection(controller)),
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
                    _buildButtomBar(context, controller)
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Padding _buildButtomBar(BuildContext context, FeedController controller) {
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
                onPressed: () {},
                icon: const Icon(
                  ImgurIconPack.upArrow,
                  size: 18,
                ),
                color:
                    isUserFeed ? appLightGrey.withOpacity(0.2) : Colors.white,
              ),
              Column(
                children: [
                  Icon(Icons.expand_less,
                      color: isUserFeed
                          ? appLightGrey.withOpacity(0.2)
                          : appLightGrey),
                  !isUserFeed
                      ? Text('${feed.points}',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))
                      : const SizedBox.shrink(),
                ],
              ),
              IconButton(
                onPressed: () {},
                color:
                    isUserFeed ? appLightGrey.withOpacity(0.2) : Colors.white,
                icon: const RotatedBox(
                    quarterTurns: 2,
                    child: Icon(
                      ImgurIconPack.upArrow,
                      size: 18,
                    )),
              ),
              IconButton(
                  onPressed: () {
                    controller.favoriteMedia(feed.id);
                  },
                  color:
                      isUserFeed ? appLightGrey.withOpacity(0.2) : Colors.white,
                  icon: const Icon(ImgurIconPack.favorite,
                      color: Colors.white, size: 18)),
              const Icon(ImgurIconPack.share, color: Colors.white, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  Widget _commentTopBar(FeedController controller) {
    return ColoredBox(
      color: appBlack,
      child: Padding(
        padding: const EdgeInsets.all(8.0).copyWith(top: 12),
        child: isUserFeed
            ? SizedBox(
                width: double.infinity,
                child: Text(
                  '${feed.views} views',
                  style: TextStyle(
                      fontSize: 12,
                      color: appLightGrey,
                      fontWeight: FontWeight.bold),
                ))
            : Row(
                children: [
                  Icon(
                    ImgurIconPack.upDown,
                    color: appLightGrey,
                    size: 15,
                  ),
                  const SizedBox(width: 5),
                  Text('BEST COMMENTS',
                      style: TextStyle(fontSize: 13, color: appLightGrey)),
                  const Spacer(),
                  InkWell(
                    onTap: () => controller.navigateToComment(feed),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.comment,
                          color: Colors.white,
                          size: 15,
                        ),
                        SizedBox(width: 5),
                        Text('COMMENT',
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  ColoredBox _buildCommentSection(FeedController controller) {
    return ColoredBox(
      color: appBlack,
      child: Column(
        children: [
          _commentTopBar(controller),
          const SizedBox(height: 10),
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

  Row _buildAppBar(BuildContext context, FeedController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
            color: Colors.white),
        profilePicture(
            isUserFeed ? controller.user.username : feed.feedAuthor!),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(feed.title ?? '',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                      isUserFeed
                          ? controller.user.username
                          : "${feed.feedAuthor} ",
                      style: TextStyle(fontSize: 16, color: appLightGrey)),
                  Visibility(
                    visible: !isUserFeed,
                    child: Icon(
                      Icons.add_circle,
                      color: appLightGrey,
                      size: 15,
                    ),
                  ),
                  const Spacer(),
                  Text(
                      isUserFeed
                          ? 'Hidden'
                          : ' ${readTimeStampDaysOnly(feed.datetime)}',
                      style: TextStyle(fontSize: 14, color: appLightGrey)),
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
                  getContentType(item.type!, item.link!, item.height,
                      width: item.width, isItem: true),
                  item.description);
            },
          )
        : itemView(
            getContentType(feed.type!, feed.link!, feed.height,
                width: feed.width, isItem: true),
            '${feed.description}');
  }

  Widget itemView(Widget media, String? description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              profilePicture(item.author, radius: 13),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            item.author.length > 28
                                ? item.author.substring(0, 28) + '...'
                                : item.author,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                                color: appLightGrey)),
                        Text(' ${String.fromCharCodes(Runes('\u00B7'))} ',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                                color: appLightGrey)),
                        Text(readTimeStampDaysOnly(item.datetime),
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: appLightGrey)),
                        const Spacer(
                          flex: 2,
                        ),
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
                      padding: const EdgeInsets.only(top: 20, bottom: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            ImgurIconPack.upArrow,
                            size: 14,
                            color: appLightGrey,
                          ),
                          Text('${item.points}',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: appLightGrey)),
                          RotatedBox(
                              quarterTurns: 2,
                              child: Icon(
                                ImgurIconPack.upArrow,
                                size: 14,
                                color: appLightGrey,
                              )),
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
