import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../constant/constant_colors.dart';
import '../../../../widgets/appbar title/appbar_title.dart';
import '../../../../widgets/navigation drawer/widget_navigation_drawer.dart';
import 'ccs_feed.dart';
import 'coa_feed.dart';
import 'cob_feed.dart';
import 'masteral_feed.dart';

final box = GetStorage();

class SelectCollegeFeed extends StatefulWidget {
  const SelectCollegeFeed({Key? key}) : super(key: key);

  @override
  State<SelectCollegeFeed> createState() => _SelectCollegeFeedState();
}

class _SelectCollegeFeedState extends State<SelectCollegeFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const WidgetNavigationDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: const AppBarTitle(
          title: 'Select College Feed',
        ),
        actions: [
          Builder(
            builder: ((context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: Icon(
                  MdiIcons.menu,
                  color: Get.isDarkMode
                      ? kButtonColorDarkTheme
                      : kButtonColorLightTheme,
                ),
              );
            }),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              AnimatedCollegeFeedButton(
                assetPath: 'assets/logo/coa.png',
                onTap: () {
                  Get.to(() => const CoaFeed());
                },
              ),
              AnimatedCollegeFeedButton(
                assetPath: 'assets/logo/cob.png',
                onTap: () {
                  Get.to(() => const CobFeed());
                },
              ),
              AnimatedCollegeFeedButton(
                assetPath: 'assets/logo/ccs.png',
                onTap: () {
                  Get.to(() => const CcsFeed());
                },
              ),
              AnimatedCollegeFeedButton(
                assetPath: 'assets/logo/masteral.png',
                onTap: () {
                  Get.to(() => const MasteralFeed());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedCollegeFeedButton extends StatelessWidget {
  const AnimatedCollegeFeedButton({
    Key? key,
    required this.assetPath,
    this.onTap,
  }) : super(key: key);
  final String assetPath;
  // ignore: prefer_typing_uninitialized_variables
  final onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AvatarGlow(
        glowColor: Get.theme.primaryColor,
        endRadius: 15.w,
        duration: const Duration(milliseconds: 2000),
        repeat: true,
        showTwoGlows: true,
        repeatPauseDuration: const Duration(milliseconds: 100),
        child: Material(
          elevation: 8.0,
          shape: const CircleBorder(),
          child: CircleAvatar(
            backgroundColor: Get.isDarkMode
                ? kTextFormFieldColorDarkTheme
                : kTextFormFieldColorLightTheme,
            child: Image.asset(
              assetPath,
              height: 5.h,
            ),
            radius: 8.w,
          ),
        ),
      ),
    );
  }
}
