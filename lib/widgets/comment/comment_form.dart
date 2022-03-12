import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../constant/constant_colors.dart';

Form buildCommentForm({
  required Key formKey,
  required void Function()? onSend,
  required TextEditingController textEditingCtrlr,
}) {
  return Form(
    key: formKey,
    child: TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          if (value.isEmpty) {
            return 'Please Enter Comment 📝';
          }
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textCapitalization: TextCapitalization.sentences,
      style: TextStyle(
        color: Get.isDarkMode ? kTextColorDarkTheme : kTextColorLightTheme,
        fontSize: 10.sp,
      ),
      autofocus: false,
      controller: textEditingCtrlr,
      //*Making the text multiline
      maxLines: 12,
      minLines: 1,
      keyboardType: TextInputType.multiline,
      textAlign: TextAlign.left,
      //*Decoration
      decoration: InputDecoration(
        //*Making the text padding to zero
        contentPadding: EdgeInsets.only(left: 1.h, top: 2.h),
        //*Hint Text
        hintText: 'Write your comment here ✏',
        suffixIcon: IconButton(
          splashColor: Colors.white,
          color: Get.isDarkMode ? kTextColorDarkTheme : kTextColorLightTheme,
          onPressed: onSend,
          icon: const Icon(Icons.send_rounded),
        ),
        hintStyle: TextStyle(
          color: Get.isDarkMode ? kTextColorDarkTheme : kTextColorLightTheme,
          fontWeight: FontWeight.w700,
          fontSize: 10.sp,
        ),
        //*Filled Color
        filled: true,
        fillColor: Get.isDarkMode
            ? kTextFormFieldColorDarkTheme
            : kTextFormFieldColorLightTheme,
        //*Enabled Border
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}
