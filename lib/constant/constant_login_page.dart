//!CONSTANT NUMBERS
//?textformfield
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/constant/constant_colors.dart';

const double kTextFormFieldRadius = 5;
const double kTextFormFieldFocusedBorderWidth = 1.0;

//!text style
TextStyle kLoginPageTextFormFieldTextStyle = TextStyle(
  color: Get.isDarkMode
      ? kTextFormFieldTextColorDarkTheme
      : kTextFormFieldTextColorLightTheme,
);
//!input border style
InputBorder kLoginPageTextFormFieldOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(kTextFormFieldRadius.w),
  borderSide: BorderSide.none,
);
InputBorder kLoginPageTextFormFieldFocusedBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Get.theme.primaryColor,
    width: kTextFormFieldFocusedBorderWidth.w,
  ),
  borderRadius: BorderRadius.circular(kTextFormFieldRadius),
);
