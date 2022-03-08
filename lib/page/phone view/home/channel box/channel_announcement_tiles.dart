import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkwell/linkwell.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weconnect/constant/constant_colors.dart';
import 'package:timeago/timeago.dart' as timeago;

channelTile({
  required String announcementMessage,
  required List announcementImageList,
  required List announcementFileList,
  required Timestamp announcementCreatedAt,
}) {
  if (announcementMessage.isNotEmpty) {
    if (announcementImageList.isNotEmpty) {
      if (announcementFileList.isNotEmpty) {
        // all field has data
        return buildChannelAllHasDataTile(
            announcementMessage: announcementMessage,
            announcementFileList: announcementFileList,
            announcementImageList: announcementImageList,
            announcementCreatedAt: announcementCreatedAt);
      } else {
        //announcement message and image only
        return buildChannelMessageAndImageTile(
            announcementMessage: announcementMessage,
            announcementImageList: announcementImageList,
            announcementCreatedAt: announcementCreatedAt);
      }
    } else if (announcementFileList.isNotEmpty) {
      //announcement message and file only
      return buildChannelMessageAndFileUrlTile(
          announcementMessage: announcementMessage,
          announcementFileList: announcementFileList,
          announcementCreatedAt: announcementCreatedAt);
    } else {
      //announcement message only
      return buildChannelMessageOnlyTile(
          announcementMessage: announcementMessage,
          announcementCreatedAt: announcementCreatedAt);
    }
  } else if (announcementImageList.isNotEmpty) {
    if (announcementFileList.isNotEmpty) {
      // image and file only
      return buildChannelImageAndFileUrlTile(
          announcementFileList: announcementFileList,
          announcementImageList: announcementImageList,
          announcementCreatedAt: announcementCreatedAt);
    } else {
      //image only
      return buildChannelImageOnly(
          announcementImageList: announcementImageList,
          announcementCreatedAt: announcementCreatedAt);
    }
  } else if (announcementFileList.isNotEmpty) {
    //file only
    return buildChannelFileOnly(
        announcementFileList: announcementFileList,
        announcementCreatedAt: announcementCreatedAt);
  }
}

Widget buildChannelMessageOnlyTile({
  required String announcementMessage,
  required Timestamp announcementCreatedAt,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.w),
    child: Container(
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? kTextFormFieldColorDarkTheme
            : kTextFormFieldColorLightTheme,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(2.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LinkWell(
                  announcementMessage,
                  linkStyle: TextStyle(
                    color: Get.theme.primaryColor,
                  ),
                  style: TextStyle(color: Get.textTheme.bodyMedium!.color),
                ),
                Text(
                  timeago.format(announcementCreatedAt.toDate(),
                      locale: 'en_short'),
                  textScaleFactor: 0.8,
                  style: TextStyle(
                    color: Get.isDarkMode
                        ? kTextColorDarkTheme
                        : kTextColorLightTheme,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildChannelImageOnly({
  required List announcementImageList,
  required Timestamp announcementCreatedAt,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.w),
    child: Container(
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? kTextFormFieldColorDarkTheme
            : kTextFormFieldColorLightTheme,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          announcementImageList.length == 1
              ? Image.network(announcementImageList.first)
              : CarouselSlider(
                  items: announcementImageList
                      .map(
                        (item) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1.w),
                          child: Image.network(
                            item,
                            fit: BoxFit.cover,
                            width: Get.mediaQuery.size.width,
                          ),
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    height: Get.mediaQuery.size.height * .5,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 900),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
          Padding(
            padding: EdgeInsets.all(2.w),
            child: Text(
              timeago.format(
                announcementCreatedAt.toDate(),
              ),
              textScaleFactor: 0.8,
              style: TextStyle(
                color:
                    Get.isDarkMode ? kTextColorDarkTheme : kTextColorLightTheme,
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget buildChannelFileOnly({
  required List announcementFileList,
  required Timestamp announcementCreatedAt,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.w),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.w),
          topRight: Radius.circular(5.w),
          bottomRight: Radius.circular(5.w),
        ),
        color: Get.isDarkMode
            ? kTextFormFieldColorDarkTheme
            : kTextFormFieldColorLightTheme,
      ),
      child: Padding(
        padding: EdgeInsets.all(3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Downloadable File Here 📁",
                  textScaleFactor: 1.2,
                  style: TextStyle(color: Get.theme.primaryColor),
                ),
              ),
              onTap: () async {
                final url = announcementFileList.first;
                if (await canLaunch(url)) launch(url);
              },
            ),
            Text(
              timeago.format(announcementCreatedAt.toDate(),
                  locale: 'en_short'),
              textScaleFactor: 0.8,
              style: TextStyle(
                color:
                    Get.isDarkMode ? kTextColorDarkTheme : kTextColorLightTheme,
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget buildChannelMessageAndImageTile({
  required String announcementMessage,
  required List announcementImageList,
  required Timestamp announcementCreatedAt,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.w),
    child: Container(
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? kTextFormFieldColorDarkTheme
            : kTextFormFieldColorLightTheme,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          announcementImageList.length == 1
              ? Image.network(announcementImageList.first)
              : CarouselSlider(
                  items: announcementImageList
                      .map(
                        (item) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1.w),
                          child: Image.network(
                            item,
                            fit: BoxFit.cover,
                            width: Get.mediaQuery.size.width,
                          ),
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    height: Get.mediaQuery.size.height * .5,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 900),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
          Padding(
            padding: EdgeInsets.all(2.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LinkWell(
                  announcementMessage,
                  linkStyle: TextStyle(
                    color: Get.theme.primaryColor,
                  ),
                  style: TextStyle(color: Get.textTheme.bodyMedium!.color),
                ),
                Text(
                  timeago.format(announcementCreatedAt.toDate(),
                      locale: 'en_short'),
                  textScaleFactor: 0.8,
                  style: TextStyle(
                    color: Get.isDarkMode
                        ? kTextColorDarkTheme
                        : kTextColorLightTheme,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildChannelMessageAndFileUrlTile({
  required String announcementMessage,
  required List announcementFileList,
  required Timestamp announcementCreatedAt,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.w),
    child: Container(
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? kTextFormFieldColorDarkTheme
            : kTextFormFieldColorLightTheme,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Downloadable File Here 📁",
                textScaleFactor: 1.2,
                style: TextStyle(color: Get.theme.primaryColor),
              ),
            ),
            onTap: () async {
              final url = announcementFileList.first;
              if (await canLaunch(url)) launch(url);
            },
          ),
          Padding(
            padding: EdgeInsets.all(2.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LinkWell(
                  announcementMessage,
                  linkStyle: TextStyle(
                    color: Get.theme.primaryColor,
                  ),
                  style: TextStyle(color: Get.textTheme.bodyMedium!.color),
                ),
                Text(
                  timeago.format(announcementCreatedAt.toDate(),
                      locale: 'en_short'),
                  textScaleFactor: 0.8,
                  style: TextStyle(
                    color: Get.isDarkMode
                        ? kTextColorDarkTheme
                        : kTextColorLightTheme,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildChannelImageAndFileUrlTile({
  required List announcementFileList,
  required List announcementImageList,
  required Timestamp announcementCreatedAt,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.w),
    child: Container(
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? kTextFormFieldColorDarkTheme
            : kTextFormFieldColorLightTheme,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          announcementImageList.length == 1
              ? Image.network(announcementImageList.first)
              : CarouselSlider(
                  items: announcementImageList
                      .map(
                        (item) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1.w),
                          child: Image.network(
                            item,
                            fit: BoxFit.cover,
                            width: Get.mediaQuery.size.width,
                          ),
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    height: Get.mediaQuery.size.height * .5,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 900),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Downloadable File Here 📁",
                textScaleFactor: 1.2,
                style: TextStyle(color: Get.theme.primaryColor),
              ),
            ),
            onTap: () async {
              final url = announcementFileList.first;
              if (await canLaunch(url)) launch(url);
            },
          ),
          Padding(
            padding: EdgeInsets.all(2.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  timeago.format(announcementCreatedAt.toDate(),
                      locale: 'en_short'),
                  textScaleFactor: 0.8,
                  style: TextStyle(
                    color: Get.isDarkMode
                        ? kTextColorDarkTheme
                        : kTextColorLightTheme,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildChannelAllHasDataTile({
  required String announcementMessage,
  required List announcementFileList,
  required List announcementImageList,
  required Timestamp announcementCreatedAt,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.w),
    child: Container(
      decoration: BoxDecoration(
        color: Get.isDarkMode
            ? kTextFormFieldColorDarkTheme
            : kTextFormFieldColorLightTheme,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          announcementImageList.length == 1
              ? Image.network(announcementImageList.first)
              : CarouselSlider(
                  items: announcementImageList
                      .map(
                        (item) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1.w),
                          child: Image.network(
                            item,
                            fit: BoxFit.cover,
                            width: Get.mediaQuery.size.width,
                          ),
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    height: Get.mediaQuery.size.height * .5,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 900),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Downloadable File Here 📁",
                textScaleFactor: 1.2,
                style: TextStyle(color: Get.theme.primaryColor),
              ),
            ),
            onTap: () async {
              final url = announcementFileList.first;
              if (await canLaunch(url)) launch(url);
            },
          ),
          Padding(
            padding: EdgeInsets.all(2.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LinkWell(
                  announcementMessage,
                  linkStyle: TextStyle(
                    color: Get.theme.primaryColor,
                  ),
                  style: TextStyle(color: Get.textTheme.bodyMedium!.color),
                ),
                Text(
                  timeago.format(announcementCreatedAt.toDate(),
                      locale: 'en_short'),
                  textScaleFactor: 0.8,
                  style: TextStyle(
                    color: Get.isDarkMode
                        ? kTextColorDarkTheme
                        : kTextColorLightTheme,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
