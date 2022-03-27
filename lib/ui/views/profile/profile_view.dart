import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:imgur/app/barrel.dart';
import 'package:imgur/data/controllers/account_controller.dart';
import 'package:imgur/ui/widgets/cont_widget.dart';
import 'package:imgur/ui/widgets/video_thumbnail.dart';
import 'dart:math' as math;

import 'favorite_view.dart';
import 'posts_view.dart';

//TODO: Add title and lenght to album
class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<AccountController>(
        onModelReady: (controller) => controller.getAccountInfo(),
        builder: (context, controller, child) {
          return Scaffold(
            backgroundColor: appBlack,
            body: DefaultTabController(
              length: 3,
              child: NestedScrollView(
                floatHeaderSlivers: true,
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      expandedHeight: 200,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.none,
                        background: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/images/profile_background.jpeg',
                                  ))),
                          child: SafeArea(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                profilePicture(controller.currentUser.username,
                                    radius: 30),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  controller.currentUser.username,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text("Neutral . 0 Points . 1 Trophy",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white)),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text("Created March 19, 2022",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      backgroundColor: Colors.green,
                      centerTitle: true,
                      pinned: true,
                      floating: true,
                      actions: [
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: IconButton(
                              icon: const Icon(Icons.compare_arrows),
                              onPressed: () {},
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.settings),
                          onPressed: () {},
                        ),
                      ],
                      bottom: const TabBar(
                          indicatorColor: Colors.black,
                          labelPadding: EdgeInsets.only(
                            bottom: 16,
                          ),
                          tabs: [
                            Text("Posts"),
                            const Text("Favorites"),
                            const Text("Comments"),
                          ]),
                    ),
                  ];
                },
                body: TabBarView(
                  children: [
                    ProfileListItem(
                      controller: controller,
                    ),
                    FavoritesListItem(
                      controller: controller,
                    ),
                    CommentListView(
                      controller: controller,
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class CommentListView extends StatelessWidget {
  final AccountController controller;
  const CommentListView({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.userComments.isNotEmpty
        ? ListView.builder(
            itemCount: controller.userComments.length,
            padding: const EdgeInsets.all(2),
            itemBuilder: (context, index) {
              final commentItem = controller.userComments[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8)
                    .copyWith(bottom: 10, top: 10),
                child: Row(
                  children: [
                    SizedBox(
                        width: 80,
                        height: 80,
                        child: getContentType(commentItem.coverType!,
                            commentItem.coverLink!, 80)),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${commentItem.comment} Are human too',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16)),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_upward_outlined,
                              color: appLightGrey,
                              size: 13,
                            ),
                            const SizedBox(width: 5),
                             Text('1',
                                style:  TextStyle(
                                    color: appLightGrey, fontSize: 13)),
                            const SizedBox(width: 5),
                            Icon(
                              Icons.access_time,
                              color: appLightGrey,
                              size: 13,
                            ),
                            const SizedBox(width: 5),
                             Text('6d',
                                style:  TextStyle(
                                    color: appLightGrey, fontSize: 13))
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            })
        : const Center(
            child: Text('No Albums',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          );
  }
}
