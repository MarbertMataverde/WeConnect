import 'dart:developer';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/authentication/authentication_controller.dart';
import 'package:weconnect/constant/constant_colors.dart';
import 'package:weconnect/controller/controller_account_type_getter.dart';
import 'package:weconnect/controller/controller_upload_post.dart';
import 'package:weconnect/page/phone%20view/home/upload/upload_post.dart';

import 'campus_feed.dart';

//firestore initialization
final firestore = FirebaseFirestore.instance;

final _pages = [
  const CampusFeed(),
  //TODO add more pages
];
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
  final _accountType = box.read('accountType');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CampusFeed(),
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
