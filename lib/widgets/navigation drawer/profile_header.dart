import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constant/constant.dart';

Widget drawerProfileHeader({
  required String profileImageUrl,
  required String profileName,
  required String profileAccountCollegeType,
  VoidCallback? onCliked,
}) {
  return InkWell(
    onTap: onCliked,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                profileName,
                textScaleFactor: 1.1,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                profileAccountCollegeType,
                textScaleFactor: 0.7,
                style: const TextStyle(),
              ),
            ],
          ),
          SizedBox(
            width: 1.w,
          ),
          CircleAvatar(
            backgroundColor: Colors.transparent,
            child: ClipOval(
              child: FadeInImage.assetNetwork(
                placeholder: randomAvatarImageAsset(),
                image: profileImageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
