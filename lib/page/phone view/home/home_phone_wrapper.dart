import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../controller/controller_account_information.dart';
import '../../phone%20view/home/channel%20box/channel_list.dart';
import 'forum/forum_topic_list.dart';
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
    final pages = [
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
      body: pages[_currentIndex],
      bottomNavigationBar: GNav(
        activeColor: Theme.of(context).textTheme.bodyMedium!.color,
        padding: EdgeInsets.all(5.w),
        color: Theme.of(context).iconTheme.color,
        gap: 2.w,
        curve: Curves.easeInOutCubicEmphasized,
        duration: const Duration(milliseconds: 200),
        tabs: const [
          GButton(
            icon: Iconsax.home,
            text: 'Campus',
          ),
          GButton(
            icon: Iconsax.teacher,
            text: 'College',
          ),
          GButton(
            icon: Iconsax.direct,
            text: 'Group',
          ),
          GButton(
            icon: Iconsax.messages_3,
            text: 'Forum',
          ),
        ],
        selectedIndex: _currentIndex,
        onTabChange: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}
