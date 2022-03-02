import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constant/constant_colors.dart';

Widget drawerItems({
  required String title,
  required IconData icon,
  VoidCallback? onCliked,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 5.w),
    child: ListTile(
      trailing: Icon(
        icon,
        color: Get.isDarkMode ? kButtonColorDarkTheme : kButtonColorLightTheme,
      ),
      title: Text(
        title,
        style: TextStyle(
          color:
              Get.isDarkMode ? kButtonColorDarkTheme : kButtonColorLightTheme,
        ),
      ),
      onTap: onCliked,
    ),
  );
}
