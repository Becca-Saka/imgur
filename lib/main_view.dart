import 'package:coolicons/coolicons.dart';
import 'package:flutter/material.dart';
import 'package:imgur/home.dart';

import 'shared/const_color.dart';

class MainView extends StatefulWidget {
  const MainView({ Key? key }) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody() ,
      //TODO: change bottombar icons
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: appBlack,
        unselectedItemColor: Colors.black,
        selectedItemColor: appGreen,
        currentIndex: currentIndex,
        iconSize: 30,
        onTap: onTabChanged,
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
  }

  onTabChanged(int index) {
    currentIndex = index;
    setState(() {});

  }

   int currentIndex =0;

  Widget getBody() {
    List<Widget> pages = [
      HomeView(),
      Container(
        color: appBlue,
      ),
      Container(
        color: appGreen,
      
      ),
    ];
    return IndexedStack(
      index: currentIndex,
      children: pages,
    );
  }
}