import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

SnackbarController buildCustomSnakbar({
  required BuildContext context,
  required IconData icon,
  required String message,
}) {
  return Get.showSnackbar(
    GetSnackBar(
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      margin: EdgeInsets.all(2.w),
      borderRadius: 1.w,
      backgroundColor: Theme.of(context).primaryColor,
      message: message,
      duration: const Duration(milliseconds: 1500),
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    ),
  );
}
