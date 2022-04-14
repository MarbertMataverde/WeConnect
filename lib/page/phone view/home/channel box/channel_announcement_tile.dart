import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkwell/linkwell.dart';
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import '../../../phone%20view/home/channel%20box/channel_annoucnement_clicked.dart';

channelTile({
  required BuildContext context,
  required String announcementMessage,
  required List announcementImageList,
  required List fileUrl,
  required Timestamp announcementCreatedAt,
}) {
  if (announcementMessage.isNotEmpty) {
    if (announcementImageList.isNotEmpty) {
      if (fileUrl.isNotEmpty) {
        // all field has data
        return buildChannelAllHasDataTile(
            context: context,
            announcementMessage: announcementMessage,
            fileUrl: fileUrl,
            announcementImageList: announcementImageList,
            announcementCreatedAt: announcementCreatedAt);
      } else {
        //announcement message and image only
        return buildChannelMessageAndImageTile(
            context: context,
            announcementMessage: announcementMessage,
            announcementImageList: announcementImageList,
            announcementCreatedAt: announcementCreatedAt);
      }
    } else if (fileUrl.isNotEmpty) {
      //announcement message and file only
      return buildChannelMessageAndFileUrlTile(
          context: context,
          announcementMessage: announcementMessage,
          fileUrl: fileUrl,
          announcementCreatedAt: announcementCreatedAt);
    } else {
      //announcement message only
      return buildChannelMessageOnlyTile(
          context: context,
          announcementMessage: announcementMessage,
          announcementCreatedAt: announcementCreatedAt);
    }
  } else if (announcementImageList.isNotEmpty) {
    if (fileUrl.isNotEmpty) {
      // image and file only
      return buildChannelImageAndFileUrlTile(
          context: context,
          fileUrl: fileUrl,
          announcementImageList: announcementImageList,
          announcementCreatedAt: announcementCreatedAt);
    } else {
      //image only
      return buildChannelImageOnly(
          context: context,
          announcementImageList: announcementImageList,
          announcementCreatedAt: announcementCreatedAt);
    }
  } else if (fileUrl.isNotEmpty) {
    //file only
    return buildChannelFileOnly(
        context: context,
        fileUrl: fileUrl,
        announcementCreatedAt: announcementCreatedAt);
  }
}

Widget buildChannelMessageOnlyTile({
  required context,
  required String announcementMessage,
  required Timestamp announcementCreatedAt,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.w),
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withAlpha(30),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(2.w),
          bottomRight: Radius.circular(2.w),
          bottomLeft: Radius.circular(2.w),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            linkWell(
                context: context, announcementMessage: announcementMessage),
            announcementTime(context, announcementCreatedAt),
          ],
        ),
      ),
    ),
  );
}

Widget buildChannelImageOnly({
  required BuildContext context,
  required List announcementImageList,
  required Timestamp announcementCreatedAt,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.w),
    child: Stack(
      alignment: Alignment.bottomRight,
      children: [
        announcementImageList.length == 1
            ? singleImage(announcementImageList)
            : carouselSlider(
                announcementImageList,
                context: context,
              ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: announcementTime(context, announcementCreatedAt),
        ),
      ],
    ),
  );
}

Widget buildChannelFileOnly({
  required BuildContext context,
  required List fileUrl,
  required Timestamp announcementCreatedAt,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.w),
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withAlpha(30),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(2.w),
          bottomRight: Radius.circular(2.w),
          bottomLeft: Radius.circular(2.w),
          topLeft: Radius.circular(2.w),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(2.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              child: Text(
                getFileName(fileUrl.first),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () async {
                final url = fileUrl.first;
                if (await canLaunch(url)) launch(url);
              },
            ),
            announcementTime(context, announcementCreatedAt),
          ],
        ),
      ),
    ),
  );
}

Widget buildChannelMessageAndImageTile({
  required BuildContext context,
  required String announcementMessage,
  required List announcementImageList,
  required Timestamp announcementCreatedAt,
}) {
  return GestureDetector(
    onTap: () => Get.to(
      () => ChannelTileCliked(
        announcementImageList: announcementImageList,
        announcementMessage: announcementMessage,
      ),
      transition: Transition.downToUp,
      duration: const Duration(milliseconds: 700),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.w),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          announcementImageList.length == 1
              ? singleImage(announcementImageList)
              : carouselSlider(
                  announcementImageList,
                  context: context,
                ),
          Padding(
            padding: EdgeInsets.all(3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                linkWell(
                  maxLines: 3,
                  context: context,
                  announcementMessage: announcementMessage,
                ),
                announcementTime(context, announcementCreatedAt)
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildChannelMessageAndFileUrlTile({
  required BuildContext context,
  required String announcementMessage,
  required List fileUrl,
  required Timestamp announcementCreatedAt,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.w),
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withAlpha(30),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(2.w),
          bottomRight: Radius.circular(2.w),
          bottomLeft: Radius.circular(2.w),
          topLeft: Radius.circular(2.w),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            linkWell(
                context: context, announcementMessage: announcementMessage),
            SizedBox(height: 1.h),
            GestureDetector(
              child: Text(
                getFileName(fileUrl.first),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () async {
                final url = fileUrl.first;
                if (await canLaunch(url)) launch(url);
              },
            ),
            announcementTime(context, announcementCreatedAt),
          ],
        ),
      ),
    ),
  );
}

Widget buildChannelImageAndFileUrlTile({
  required BuildContext context,
  required List fileUrl,
  required List announcementImageList,
  required Timestamp announcementCreatedAt,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.w),
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).textTheme.bodyMedium!.color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          announcementImageList.length == 1
              ? Image.network(announcementImageList.first)
              : carouselSlider(
                  announcementImageList,
                  context: context,
                ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Downloadable File Here 📁",
                textScaleFactor: 1.2,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            onTap: () async {
              final url = fileUrl.first;
              if (await canLaunch(url)) launch(url);
            },
          ),
          Padding(
            padding: EdgeInsets.all(2.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                timeAgoFormat(
                  context: context,
                  announcementCreatedAt: announcementCreatedAt,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildChannelAllHasDataTile({
  required BuildContext context,
  required String announcementMessage,
  required List fileUrl,
  required List announcementImageList,
  required Timestamp announcementCreatedAt,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.w),
    child: Container(
      decoration: BoxDecoration(
        color: Theme.of(context).textTheme.bodyMedium!.color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          announcementImageList.length == 1
              ? Image.network(announcementImageList.first)
              : carouselSlider(
                  announcementImageList,
                  context: context,
                ),
          GestureDetector(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Downloadable File Here 📁",
                textScaleFactor: 1.2,
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            onTap: () async {
              final url = fileUrl.first;
              if (await canLaunch(url)) launch(url);
            },
          ),
          Padding(
            padding: EdgeInsets.all(2.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                linkWell(
                    context: context, announcementMessage: announcementMessage),
                timeAgoFormat(
                  context: context,
                  announcementCreatedAt: announcementCreatedAt,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

CarouselSlider carouselSlider(
  List<dynamic> announcementImageList, {
  required BuildContext context,
}) {
  return CarouselSlider(
    items: announcementImageList
        .map(
          (item) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2.w),
                child: Image.network(
                  item,
                  width: 100.w,
                  fit: BoxFit.fitWidth,
                ),
              )),
        )
        .toList(),
    options: CarouselOptions(
      height: MediaQuery.of(context).size.height * .5,
      aspectRatio: 16 / 9,
      viewportFraction: 1,
      initialPage: 0,
      enableInfiniteScroll: false,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 5),
      autoPlayAnimationDuration: const Duration(milliseconds: 900),
      autoPlayCurve: Curves.fastOutSlowIn,
      enlargeCenterPage: true,
      scrollDirection: Axis.horizontal,
    ),
  );
}

Text timeAgoFormat({
  required BuildContext context,
  required Timestamp announcementCreatedAt,
}) {
  return Text(
    timeago.format(announcementCreatedAt.toDate(), locale: 'en_short'),
    textScaleFactor: 0.8,
    style: TextStyle(color: Theme.of(context).textTheme.labelMedium!.color),
  );
}

LinkWell linkWell({
  required BuildContext context,
  required String announcementMessage,
  int? maxLines,
}) {
  return LinkWell(
    announcementMessage,
    maxLines: maxLines,
    overflow: TextOverflow.fade,
    linkStyle: TextStyle(color: Theme.of(context).primaryColor),
    style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
  );
}

Align announcementTime(context, Timestamp announcementCreatedAt) {
  return Align(
    alignment: Alignment.centerRight,
    child: timeAgoFormat(
      context: context,
      announcementCreatedAt: announcementCreatedAt,
    ),
  );
}

ClipRRect singleImage(List<dynamic> announcementImageList) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(2.w),
    child: Image.network(announcementImageList.first),
  );
}

//this will get the file name in the firebase storage download link
String getFileName(String url) {
  RegExp regExp = RegExp(r'.+(\/|%2F)(.+)\?.+');
  //This Regex won't work if you remove ?alt...token
  var matches = regExp.allMatches(url);

  var match = matches.elementAt(0);
  return Uri.decodeFull(match.group(2)!);
}
