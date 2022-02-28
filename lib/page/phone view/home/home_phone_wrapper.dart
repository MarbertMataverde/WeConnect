import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weconnect/page/phone%20view/home/colleges/select_college.dart';

import 'campus feed/campus_feed.dart';

//firestore initialization
final firestore = FirebaseFirestore.instance;

final _pages = [
  const CampusFeed(),
  const SelectCollegeFeed(),
];
// get storage box
final box = GetStorage();

var _currentIndex = 0; //default index of a first screen

//getting the current user inforamtion

class HomePhoneWrapper extends StatefulWidget {
  const HomePhoneWrapper({Key? key}) : super(key: key);

  @override
  State<HomePhoneWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomePhoneWrapper> {
  @override
  void initState() {
    accountTypeToGetStorage();
    super.initState();
  }

  Future accountTypeToGetStorage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    box.write('accountType', sharedPreferences.get('accountType'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      // body: _pages[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(MdiIcons.newspaperVariantOutline),
            title: const Text("Campus Feed"),
            selectedColor: Colors.blue,
          ),
          SalomonBottomBarItem(
            icon: const Icon(MdiIcons.newspaperVariantMultipleOutline),
            title: const Text("College Feed"),
            selectedColor: Colors.orange,
          ),
          SalomonBottomBarItem(
            icon: const Icon(MdiIcons.messageBulleted),
            title: const Text("Channel Box"),
            selectedColor: Colors.teal,
          ),
          SalomonBottomBarItem(
            icon: const Icon(MdiIcons.forumOutline),
            title: const Text("Forum"),
            selectedColor: Colors.cyan,
          ),
        ],
      ),
    );
  }
}
