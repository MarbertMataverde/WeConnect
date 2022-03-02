import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weconnect/page/phone%20view/home/colleges/ccs_feed.dart';
import 'package:weconnect/page/phone%20view/home/colleges/coa_feed.dart';
import 'package:weconnect/page/phone%20view/home/colleges/cob_feed.dart';
import 'package:weconnect/page/phone%20view/home/colleges/masteral_feed.dart';
import 'package:weconnect/page/phone%20view/home/colleges/select_college.dart';

import 'campus feed/campus_feed.dart';

//firestore initialization
final firestore = FirebaseFirestore.instance;

//default index of a first screen
var _currentIndex = 0;

//global box
final box = GetStorage();

class HomePhoneWrapper extends StatefulWidget {
  const HomePhoneWrapper({Key? key}) : super(key: key);

  @override
  State<HomePhoneWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomePhoneWrapper> {
  String? accountType;
  String? studentCollege;
  @override
  void initState() {
    accountTypeToGetStorage();
    super.initState();
  }

  Future accountTypeToGetStorage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    accountType = sharedPreferences.get('accountType') as String;
    studentCollege = sharedPreferences.get('studentCollege').toString();
    box.write(
        'profileName', sharedPreferences.get('currentProfileName').toString());
    box.write('profileImageUrl',
        sharedPreferences.get('currentProfileImageUrl').toString());
  }

  @override
  Widget build(BuildContext context) {
    final _pages = [
      //campus feed (main feed)
      const CampusFeed(),
      //college account type based feed
      accountType == 'accountTypeCoaAdmin' ||
              studentCollege == 'College of Accountancy'
          ? const CoaFeed()
          : accountType == 'accountTypeCobAdmin' ||
                  studentCollege == 'College of Business'
              ? const CobFeed()
              : accountType == 'accountTypeCcsAdmin' ||
                      studentCollege == 'College of Computer Studies'
                  ? const CcsFeed()
                  : accountType == 'accountTypeMasteralAdmin' ||
                          studentCollege == 'Masteral'
                      ? const MasteralFeed()
                      : const SelectCollegeFeed(),
    ];
    return Scaffold(
      body: _pages[_currentIndex],
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
