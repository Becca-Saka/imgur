import 'package:flutter/material.dart';
import 'package:imgur/app/barrel.dart';
import 'package:imgur/ui/views/profile/comments_view.dart';
import 'dart:math' as math;

import 'favorite_view.dart';
import 'posts_view.dart';

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
                      elevation: 0,
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
                          transform: Matrix4.rotationY(math.pi / 90),
                          child: IconButton(
                            icon: const Icon(ImgurIconPack.upDown),
                            onPressed: () {},
                          ),
                        ),
                        RotatedBox(
                          quarterTurns: 3,
                          child: IconButton(
                            icon: const Icon(ImgurIconPack.settings),
                            onPressed: () {},
                          ),
                        ),
                      ],
                      bottom: const TabBar(
                          indicatorColor: Colors.white,
                          labelPadding: EdgeInsets.only(
                            bottom: 16,
                          ),
                          tabs: [
                            Text("Posts",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text("Favorites",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text("Comments",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
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
