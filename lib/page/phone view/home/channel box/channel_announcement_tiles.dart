import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linkwell/linkwell.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/constant/constant_colors.dart';
import 'package:timeago/timeago.dart' as timeago;

Widget buildChannelAnnouncementTile({
  required String announcementMessage,
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
              textScaleFactor: 0.7,
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
