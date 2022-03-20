import 'dart:developer';
import 'dart:typed_data';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imgur/app/barrel.dart';
import 'package:imgur/data/models/feed_model.dart';
import 'package:imgur/data/repository/feed_repository.dart';
import 'package:imgur/data/services/api_response.dart';
import 'package:imgur/ui/views/gallery_feed_list.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  List<FeedModel> feeds = [];
  List<FeedModel> viralfeeds = [];
  List<FeedModel> userSubfeeds = [];
  List<FeedModel> followingfeeds = [];
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 5, initialIndex: 0, vsync: this);
    _tabController.addListener(_handleTabSelection);
    getpost();
    super.initState();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      switch (_tabController.index) {
        case 0:
          log('home');
          break;
        case 1:
          log('home');
          break;
        case 2:
          log('home');
          break;
        case 3:
          log('home');
          break;
        case 4:
          log('home');
          break;
      }
    }
  }

  getpost() async {
    ApiResponse? response = await UserRepository().getFeed();
    if (response.isSuccessful) {
      final feedslist = response.data as List<dynamic>;
      feeds = feedslist.map((e) => FeedModel.fromJson(e)).toList();
      setState(() {});
    }
    log(response.message.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 0.97,
                colors: [Color(0xFF291765), Color(0xFF2e3035)])),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/images/appiconwhite.svg',
                  height: 22,
                  width: 22,
                ),
                const SizedBox(height: 20),
                TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: const Color(0xFF69f0ae),
                    ),
                    tabs: [
                      'Most Viral',
                      'User Sub',
                      'Following',
                      'Snacks',
                      'StoryTime'
                    ].map((e) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 8.0),
                        child: Text(
                          e,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Proxima Nova',
                              fontWeight: FontWeight.w900),
                        ),
                      );
                    }).toList()),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(math.pi),
                        child:
                            const Icon(Icons.swap_vert, color: Colors.white)),
                    const Text('Newest',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Proxima Nova',
                            fontWeight: FontWeight.w900)),
                    const Spacer(),
                    const Icon(Icons.filter_list, color: Colors.white),
                  ],
                ),
                const SizedBox(height: 10),
                // GalleryFeedList(feeds: feeds),
                getTabView()
              ],
            ),
          ),
        ),
      ),
    );
  }

  getTabView() {
    switch (_tabController.index) {
      case 0:
        return GalleryFeedList(feeds: feeds);

      case 1:
        return GalleryFeedList(feeds: viralfeeds);

      case 2:
        return GalleryFeedList(feeds: userSubfeeds);

      case 3:
        return GalleryFeedList(feeds: followingfeeds);

      case 4:
        return GalleryFeedList(feeds: followingfeeds);

      default:
        return GalleryFeedList(feeds: feeds);
    }
  }
}

class VideoItem extends StatefulWidget {
  final String url;
  const VideoItem({Key? key, required this.url}) : super(key: key);

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
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
    return uint8list != null
        ? Image.memory(
            uint8list!,
          )
        : const Text('content video');
  }
  // late VideoPlayerController _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = VideoPlayerController.network(widget.url)
  //     ..initialize().then((_) {
  //       setState(() {}); //when your thumbnail will show.
  //     });
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return _controller.value.isInitialized
  //       ? SizedBox(
  //           width: 100.0,
  //           height: 56.0,
  //           child: VideoPlayer(_controller),
  //         )
  //       : const CircularProgressIndicator();
  // }
}
