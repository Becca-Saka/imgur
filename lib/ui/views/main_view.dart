import 'package:coolicons/coolicons.dart';
import 'package:flutter/material.dart';
import 'package:imgur/app/barrel.dart';

import 'home.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<FeedController>(
        builder: (context, controller, child) {
          return Scaffold(
            body: getBody(controller),
            //TODO: change bottombar icons
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: appDeepBlack,
              unselectedItemColor: Colors.black,
              selectedItemColor: appGreen,
              currentIndex: controller.currentIndex,
              iconSize: 30,
              onTap: controller.onTabChanged,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Coolicons.home_outline),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
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
      Container(
        color: appGreen,
      ),
    ];
    return IndexedStack(
      index: controller.currentIndex,
      children: pages,
    );
  }
}
