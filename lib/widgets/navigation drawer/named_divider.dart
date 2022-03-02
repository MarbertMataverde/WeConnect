import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constant/constant_colors.dart';

Widget namedDivider({required String dividerName}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //account
      Padding(
        padding: EdgeInsets.only(left: 5.w),
        child: Text(
          dividerName,
          textScaleFactor: 1.1,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      //divider
      Divider(
        height: 0,
        indent: 5.w,
        endIndent: 5.w,
        thickness: 0.5,
        color: Get.isDarkMode ? kButtonColorDarkTheme : kButtonColorLightTheme,
      ),
    ],
  );
}
