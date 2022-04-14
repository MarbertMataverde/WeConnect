import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

GetSnackBar globalSnackBar({
  required BuildContext context,
  required String message,
  required IconData icon,
}) {
  return GetSnackBar(
    icon: Icon(
      icon,
      color: Theme.of(context).scaffoldBackgroundColor,
    ),
    margin: EdgeInsets.all(2.w),
    borderRadius: 1.w,
    backgroundColor: Theme.of(context).primaryColor.withAlpha(200),
    message: message,
    duration: const Duration(seconds: 1),
    forwardAnimationCurve: Curves.easeInOutCubicEmphasized,
  );
}
