import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/widgets/appbar/build_appbar.dart';

import '../../../../constant/constant_colors.dart';
import '../../../../widgets/navigation drawer/widget_navigation_drawer.dart';
import 'ccs_feed.dart';
import 'coa_feed.dart';
import 'cob_feed.dart';
import 'masteral_feed.dart';

List<String> data = [
  'assets/colleges/coa.png',
  'assets/colleges/cob.png',
  'assets/colleges/ccs.png',
  'assets/colleges/masteral.png',
];

List<Widget> pages = [
  const CoaFeed(),
  const CobFeed(),
  const CcsFeed(),
  const MasteralFeed(),
];

class SelectCollegeFeed extends StatefulWidget {
  const SelectCollegeFeed({Key? key}) : super(key: key);

  @override
  State<SelectCollegeFeed> createState() => _SelectCollegeFeedState();
}

class _SelectCollegeFeedState extends State<SelectCollegeFeed> {
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const WidgetNavigationDrawer(),
      appBar: buildAppBar(
        context: context,
        title: 'Select College',
        actions: [
          Builder(
            builder: ((context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: Icon(
                  Iconsax.menu,
                  color: Theme.of(context).iconTheme.color,
                ),
              );
            }),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            child: Container(
              key: ValueKey<String>(data[_currentPage]),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(data[_currentPage]),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color:
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => pages[_currentPage]);
            },
            child: FractionallySizedBox(
              heightFactor: 0.55,
              child: PageView.builder(
                itemCount: data.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  return FractionallySizedBox(
                    widthFactor: 0.8,
                    child: Container(
                      margin: EdgeInsets.all(5.w),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(data[index]),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(5.w),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.15,
            child: _currentPage == 0
                ? _buildCollegeTitleName(
                    context: context, collegeName: 'College of Accountancy')
                : _currentPage == 1
                    ? _buildCollegeTitleName(
                        context: context, collegeName: 'College of Business')
                    : _currentPage == 2
                        ? _buildCollegeTitleName(
                            context: context,
                            collegeName: 'College of Computer Studies')
                        : _currentPage == 3
                            ? _buildCollegeTitleName(
                                context: context, collegeName: 'Masteral')
                            : const Text('❌🧐❕'),
          ),
        ],
      ),
    );
  }
}

_buildCollegeTitleName({
  required context,
  required String collegeName,
}) {
  return Text(
    collegeName,
    textScaleFactor: 1.2,
    style: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  );
}
