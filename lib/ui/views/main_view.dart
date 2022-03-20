import 'dart:developer';
import 'dart:io';

import 'package:coolicons/coolicons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:imgur/app/barrel.dart';

import 'home.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      //TODO: change bottombar icons
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Color(0xFF263238),
        // backgroundColor: appBlack,
        // backgroundColor: appBlack,3c4049
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

  onTabChanged(int index) async {
    if (index == 1) {
      log('search');
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowedExtensions: ['jpg', 'png', 'gif', 'jpeg'],
      );

      if (result != null) {
        File file = File(result.files.single.path!);
      } else {
        // User canceled the picker
      }
    } else {
      currentIndex = index;
    }
    setState(() {});
  }

  int currentIndex = 0;

  Widget getBody() {
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
      index: currentIndex,
      children: pages,
    );
  }
}
