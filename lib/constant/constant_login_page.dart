//!CONSTANT NUMBERS
//?textformfield
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weconnect/constant/constant_colors.dart';

//?phone view
const double kTextFormFieldRadius = 4.0;
const double kTextFormFieldFocusedBorderWidth = 1.0;

//!text style
TextStyle kLoginPageTextFormFieldTextStyle = TextStyle(
  color: Get.isDarkMode
      ? kTextFormFieldTextColorDarkTheme
      : kTextFormFieldTextColorLightTheme,
  fontSize: 14,
);
//!input border style
InputBorder kLoginPageTextFormFieldOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(kTextFormFieldRadius),
  borderSide: BorderSide.none,
);
InputBorder kLoginPageTextFormFieldFocusedBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Get.theme.primaryColor,
    width: kTextFormFieldFocusedBorderWidth,
  ),
  borderRadius: BorderRadius.circular(kTextFormFieldRadius),
);
