import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/constant_colors.dart';

Widget buildAppbarBackButton() {
  return IconButton(
    onPressed: () {
      Get.back();
    },
    icon: Icon(
      Icons.arrow_back_rounded,
      color: Get.isDarkMode ? kTextColorDarkTheme : kTextColorLightTheme,
    ),
  );
}
