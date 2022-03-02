import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

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
      child: SizedBox(
        width: 100.w,
        height: 10.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  profileName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  profileAccountCollegeType,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 8.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 1.w,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(profileImageUrl),
              radius: 4.h,
            )
          ],
        ),
      ),
    ),
  );
}
