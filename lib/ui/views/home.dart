import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imgur/app/appstate.dart';
import 'package:imgur/data/controllers/feed_controller.dart';
import 'package:imgur/ui/views/gallery_feed_list.dart';
import 'package:imgur/ui/widgets/loading_placeholder.dart';

import 'base_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  void _handleTabSelection(FeedController controller) {
    if (_tabController.indexIsChanging) {
      log('Tab index is changing ${_tabController.index}');
      controller.handleTabChange(_tabController.index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<FeedController>(onModelReady: (controller) {
      _tabController = TabController(length: 5, initialIndex: 0, vsync: this);
      _tabController.addListener(() => _handleTabSelection(controller));
      controller.getViralFeeds();
    }, builder: (context, controller, child) {
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
                  Expanded(
                    child: controller.state == AppState.busy
                        ? const LoadingPlaceholder()
                        : TabBarView(controller: _tabController, children: [
                            GalleryFeedList(feeds: controller.viralfeeds),
                            GalleryFeedList(feeds: controller.userSubfeeds),
                            GalleryFeedList(feeds: controller.followingfeeds),
                            GalleryFeedList(feeds: controller.feeds),
                            GalleryFeedList(feeds: controller.feeds),
                          ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
