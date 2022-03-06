import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controller/controller_account_information.dart';
import '../../phone%20view/home/channel%20box/channel_list.dart';
import '../../phone%20view/home/forum/forum.dart';
import 'campus feed/campus_feed.dart';
import 'colleges/ccs_feed.dart';
import 'colleges/coa_feed.dart';
import 'colleges/cob_feed.dart';
import 'colleges/masteral_feed.dart';
import 'colleges/select_college.dart';

//firestore initialization
final firestore = FirebaseFirestore.instance;

//default index of a first screen
var _currentIndex = 0;

//global box
final box = GetStorage();

class HomePhoneWrapper extends StatefulWidget {
  const HomePhoneWrapper({Key? key}) : super(key: key);

  @override
  State<HomePhoneWrapper> createState() => _HomePhoneWrapperState();
}

//get account information
final accountInformation = Get.put(ControllerAccountInformation());

class _HomePhoneWrapperState extends State<HomePhoneWrapper> {
  @override
  void initState() {
    getAccountInformation();
    super.initState();
  }

  Future getAccountInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    accountInformation.getter(sharedPreferences.get('currentUid').toString());
  }

  @override
  Widget build(BuildContext context) {
    final _pages = [
      //campus feed (main feed)
      const CampusFeed(),
      //college account type based feed
      currentAccountType == 'accountTypeCoaAdmin' ||
              currentStudentCollege == 'College of Accountancy'
          ? const CoaFeed()
          : currentAccountType == 'accountTypeCobAdmin' ||
                  currentStudentCollege == 'College of Business'
              ? const CobFeed()
              : currentAccountType == 'accountTypeCcsAdmin' ||
                      currentStudentCollege == 'College of Computer Studies'
                  ? const CcsFeed()
                  : currentAccountType == 'accountTypeMasteralAdmin' ||
                          currentStudentCollege == 'Masteral'
                      ? const MasteralFeed()
                      : const SelectCollegeFeed(),
      const ChannelList(),
      const Forum(),
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
