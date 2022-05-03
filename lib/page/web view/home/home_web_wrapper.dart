import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/page/web%20view/home/home_new_admin_account.dart';

import '../../../authentication/authentication_controller.dart';
import '../../../controller/controller_post_tile_pop_up_menu.dart';
import 'home_student_axcode.dart';

final authentication = Get.put(Authentication());

class HomeWebWrapper extends StatefulWidget {
  const HomeWebWrapper({Key? key}) : super(key: key);

  @override
  State<HomeWebWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWebWrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          meneHolder(context),
        ],
      ),
      body: const StudentAxCodeGenerator(),
    );
  }
}

FocusedMenuHolder meneHolder(BuildContext context) {
  return FocusedMenuHolder(
    menuWidth: MediaQuery.of(context).size.width * 0.30,
    blurSize: 1.0,
    menuBoxDecoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(1.w))),
    duration: const Duration(milliseconds: 100),
    animateMenuItems: false,
    blurBackgroundColor: Colors.black,
    openWithTap: true,
    onPressed: () {},
    menuItems: [
      // focusMenuItem(
      //   'New Admin Account',
      //   Iconsax.flash,
      //   Colors.black54,
      //   () {
      //     Get.to(() => const NewAdminAccount());
      //   },
      // ),
      focusMenuItem(
        'Sign Out',
        Iconsax.logout,
        Colors.black54,
        () {
          authentication.signOut();
        },
      ),
    ],
    child: Padding(
      padding: EdgeInsets.only(right: 2.w),
      child: Icon(
        Iconsax.menu,
        color: Theme.of(context).iconTheme.color,
      ),
    ),
  );
}
