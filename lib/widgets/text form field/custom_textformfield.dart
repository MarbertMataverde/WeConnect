import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../constant/constant.dart';
import '../../constant/constant_colors.dart';
import '../../constant/constant_login_page.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.ctrlr,
    required this.hint,
    required this.isPassword,
    this.keyboardType,
    required this.validator,
    this.inputFormater,
    this.minimumLine,
    this.maxLine,
    this.autovalidateMode,
    this.onChanged,
  }) : super(key: key);
  //?controller
  final TextEditingController ctrlr;
  //?hint
  final String hint;
  //?it is password or not
  final bool isPassword;
  final TextInputType? keyboardType;
  // ignore: prefer_typing_uninitialized_variables
  final validator;
  final List<TextInputFormatter>? inputFormater;
  //?minumum lines
  final int? minimumLine;
  //?max lines
  final int? maxLine;
  //?auto validation
  final AutovalidateMode? autovalidateMode;
  //?on data change
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: minimumLine,
      maxLines: maxLine,
      validator: validator,
      inputFormatters: inputFormater,
      keyboardType: keyboardType,
      controller: ctrlr,
      obscureText: isPassword,
      autovalidateMode: autovalidateMode,
      onChanged: onChanged,
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
