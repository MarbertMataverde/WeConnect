import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:sizer/sizer.dart';

import '../../constant/constant_colors.dart';

class CommentTile extends StatelessWidget {
  const CommentTile({
    Key? key,
    required this.profileUrl,
    required this.comment,
    required this.profileName,
    required this.createdAt,
  }) : super(key: key);
  final String profileUrl;
  final String comment;
  final String profileName;
  final Timestamp createdAt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 14.sp,
                backgroundImage: NetworkImage(profileUrl),
              ),
              SizedBox(
                width: 3.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profileName,
                    style: TextStyle(
                      color: Get.textTheme.subtitle1!.color,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    timeago.format(createdAt.toDate()),
                    style: TextStyle(
                      color: Get.isDarkMode
                          ? kTextColorDarkTheme
                          : kTextColorLightTheme,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.w),
            child: ExpandableText(
              comment,
              maxLines: 4,
              expandText: 'read more',
              collapseText: 'collapse',
              expandOnTextTap: true,
              collapseOnTextTap: true,
              animation: true,
              animationCurve: Curves.fastLinearToSlowEaseIn,
              style: TextStyle(
                color: Get.textTheme.subtitle1!.color,
              ),
            ),
          ),
          Divider(
            color: Get.theme.primaryColor,
          )
        ],
      ),
    );
  }
}
