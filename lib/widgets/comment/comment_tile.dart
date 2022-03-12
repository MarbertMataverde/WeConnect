import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../constant/constant.dart';
import '../../constant/constant_colors.dart';

Widget buildCommentTile({
  required String profileImageUrl,
  required String profileName,
  required Timestamp commentedDate,
  required String comment,
}) {
  return ListTile(
    leading: CircleAvatar(
      backgroundColor: Colors.transparent,
      child: ClipOval(
        child: FadeInImage.assetNetwork(
          placeholder: randomAvatarImageAsset(),
          image: profileImageUrl,
          fit: BoxFit.cover,
        ),
      ),
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          profileName,
          style: TextStyle(
            color: Get.theme.primaryColor,
            fontSize: 12.sp,
          ),
        ),
        Text(
          timeago.format(
            commentedDate.toDate(),
          ),
          style: TextStyle(
              fontSize: 8.sp,
              color:
                  Get.isDarkMode ? kTextColorDarkTheme : kTextColorLightTheme),
        ),
      ],
    ),
    subtitle: Padding(
      padding: EdgeInsets.only(top: 1.h),
      child: ExpandableText(
        comment,
        maxLines: 3,
        expandText: 'more',
        collapseText: 'less',
        expandOnTextTap: true,
        collapseOnTextTap: true,
        animation: true,
        animationCurve: Curves.fastLinearToSlowEaseIn,
        style: TextStyle(
          color: Get.textTheme.subtitle1!.color,
        ),
      ),
    ),
  );
}
