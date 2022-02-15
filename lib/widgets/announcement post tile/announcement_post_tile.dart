import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/constant/constant_colors.dart';
import 'package:timeago/timeago.dart' as timeago;

DateFormat dateFormat = DateFormat("MMM-dd");

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
    log(postCreatedAt.toString());
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
                InkWell(
                  onTap: () {
                    Get.bottomSheet(Container(
                      height: 20.h,
                      color: Get.isDarkMode
                          ? kTextFormFieldColorDarkTheme
                          : kTextFormFieldColorLightTheme,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton.icon(
                              style: TextButton.styleFrom(
                                //style
                                primary: Get.isDarkMode
                                    ? kTextColorDarkTheme
                                    : kTextColorLightTheme,
                              ),
                              onPressed: () {},
                              icon: const Icon(Icons.delete_forever_rounded),
                              label: const Text('Delete Post 🗑️')),
                          Divider(
                            thickness: 0.7,
                            indent: 5.w,
                            endIndent: 5.w,
                            color: Get.isDarkMode
                                ? kTextColorDarkTheme
                                : kTextColorLightTheme,
                          ),
                          TextButton.icon(
                              style: TextButton.styleFrom(
                                //style
                                primary: Get.isDarkMode
                                    ? kTextColorDarkTheme
                                    : kTextColorLightTheme,
                              ),
                              onPressed: () {},
                              icon: const Icon(Icons.edit_rounded),
                              label: const Text('Edit Post 🖊')),
                        ],
                      ),
                    ));
                  },
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
              ? InkWell(
                  onTap: () {
                    log('imaged cliked');
                  },
                  child: Image.network(postMedia.first),
                )
              : InkWell(
                  onTap: () {
                    log('imaged cliked');
                  },
                  child: CarouselSlider(
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
