import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/constant.dart';
import '../constant/constant_colors.dart';
import '../constant/constant_login_page.dart';

class LoginPageTextFormField extends StatelessWidget {
  const LoginPageTextFormField({
    Key? key,
    required this.ctrlr,
    required this.hint,
    required this.isPassword,
  }) : super(key: key);
  //?controller
  final TextEditingController ctrlr;
  //?hint
  final String hint;
  //?it is password or not
  final bool isPassword;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: ctrlr,
      obscureText: isPassword,
      style: kLoginPageTextFormFieldTextStyle,
      cursorColor: Get.isDarkMode
          ? kTextFormFieldCursorColorDarkTheme
          : kTextFormFieldCursorColorLightTheme,
      decoration: InputDecoration(
        filled: kTrue,
        fillColor: Get.isDarkMode
            ? kTextFormFieldColorDarkTheme
            : kTextFormFieldColorLightTheme,
        hintText: hint,
        border: kLoginPageTextFormFieldOutlineInputBorder,
        focusedBorder: kLoginPageTextFormFieldFocusedBorder,
      ),
    );
  }
}
