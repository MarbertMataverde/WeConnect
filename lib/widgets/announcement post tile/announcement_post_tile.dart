import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/constant/constant_colors.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:weconnect/controller/controller_post_tile_pop_up_menu.dart';

DateFormat dateFormat = DateFormat("MMM-dd");

//account type
final box = GetStorage();

//pop up based on account type
final popUpMenu = Get.put(ControllerPostTilePopUpMenu());

class AnnouncementPostTile extends StatelessWidget {
  const AnnouncementPostTile({
    Key? key,
    required this.postCreatedAt,
    required this.accountName,
    required this.postDescription,
    required this.accountProfileImageUrl,
    required this.postMedia,
  }) : super(key: key);
  //when announcement post created
  final Timestamp postCreatedAt;
  //account name
  final String accountName;
  //description of the post
  final String postDescription;
  //account prifile image url
  final String accountProfileImageUrl;
  //post images or media
  final List postMedia;

  @override
  Widget build(BuildContext context) {
    final _accountType = box.read('accountType');
    return Card(
      elevation: 3,
      color: Get.isDarkMode ? kTextFormFieldColorDarkTheme : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    //profile image
                    CircleAvatar(
                      radius: 14.sp,
                      backgroundImage: NetworkImage(accountProfileImageUrl),
                    ),
                    SizedBox(
                      width: 3.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //account name
                        Text(
                          accountName,
                          style: TextStyle(
                            color: Get.isDarkMode
                                ? kTextColorDarkTheme
                                : kTextColorLightTheme,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        //when post created with time ago format
                        Text(
                          timeago.format(postCreatedAt.toDate()),
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: Get.isDarkMode
                                ? kTextColorDarkTheme
                                : kTextColorLightTheme,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                FocusedMenuHolder(
                  menuWidth: MediaQuery.of(context).size.width * 0.50,
                  blurSize: 1.0,
                  menuItemExtent: 5.h,
                  menuBoxDecoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(1.w))),
                  duration: const Duration(milliseconds: 100),
                  animateMenuItems: true,
                  blurBackgroundColor: Colors.black,
                  openWithTap: true,
                  menuOffset: 1.h,
                  onPressed: () {},
                  menuItems: _accountType == 'accountTypeCampusAdmin' ||
                          _accountType == 'accountTypeRegistrarAdmin'
                      ? popUpMenu.campusAndRegistrarAdminMenuItem
                      : popUpMenu.professorsAndStudentsMenuItem,
                  child: Icon(
                    Icons.more_vert_rounded,
                    color: Get.isDarkMode
                        ? kTextColorDarkTheme
                        : kTextColorLightTheme,
                    size: 13.sp,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpandableText(
              postDescription,
              style: TextStyle(
                color:
                    Get.isDarkMode ? kTextColorDarkTheme : kTextColorLightTheme,
              ),
              maxLines: 3,
              expandText: 'more',
              expandOnTextTap: true,
              collapseOnTextTap: true,
              collapseText: 'collapse',
              animation: true,
              animationCurve: Curves.fastLinearToSlowEaseIn,
            ),
          ),
          postMedia.length == 1
              ? Image.network(postMedia.first)
              : CarouselSlider(
                  items: postMedia
                      .map(
                        (item) => Image.network(
                          item,
                          fit: BoxFit.cover,
                          width: 100.w,
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    pageSnapping: true,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    autoPlay: true,
                    autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                  ),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {},
                child: Align(
                  alignment: Alignment.center,
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      primary: Get.isDarkMode
                          ? kTextColorDarkTheme
                          : kTextColorLightTheme,
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.message),
                    label: Text(
                      'Write and show comments',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
