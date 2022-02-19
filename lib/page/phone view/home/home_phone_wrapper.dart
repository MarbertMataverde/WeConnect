import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:weconnect/authentication/authentication_controller.dart';
import 'package:weconnect/controller/controller_account_type_getter.dart';

import 'campus_feed.dart';

//firestore initialization
final firestore = FirebaseFirestore.instance;

// final _pages = [
//   const CampusFeed(),
// ];
// get storage box
final box = GetStorage();

var _currentIndex = 0; //default index of a first screen

//authentication injection
final authentication = Get.put(Authentication());

final getAccountType = Get.put(AccountType());

class HomePhoneWrapper extends StatefulWidget {
  const HomePhoneWrapper({Key? key}) : super(key: key);

  @override
  State<HomePhoneWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomePhoneWrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const CampusFeed(),
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
