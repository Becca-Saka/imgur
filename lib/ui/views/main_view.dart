import 'package:flutter/material.dart';
import 'package:imgur/app/barrel.dart';
import 'package:imgur/ui/views/profile/profile_view.dart';

import 'feed/home.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<FeedController>(
        builder: (context, controller, child) {
          return Scaffold(
            body: getBody(controller),
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: appDeepBlack,
              unselectedItemColor: Colors.white,
              selectedItemColor: appGreen,
              currentIndex: controller.currentIndex,
              iconSize: 30,
              onTap: controller.onTabChanged,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(ImgurIconPack.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(ImgurIconPack.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        });
  }

  Widget getBody(FeedController controller) {
    List<Widget> pages = [
      const HomeView(),
      Container(
        color: appBlue,
      ),
      const ProfileView()
    ];
    return IndexedStack(
      index: controller.currentIndex,
      children: pages,
    );
  }
}
