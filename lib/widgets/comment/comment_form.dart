import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';

import '../../constant/constant_login_page.dart';

Form buildCommentForm({
  required BuildContext context,
  required Key formKey,
  required void Function()? onSend,
  required TextEditingController textEditingCtrlr,
}) {
  return Form(
    key: formKey,
    child: TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return;
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textCapitalization: TextCapitalization.sentences,
      style: TextStyle(
        color: Theme.of(context).textTheme.labelMedium!.color,
        fontSize: 12.sp,
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
        errorStyle: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
        //*Hint Text
        hintText: 'Say something...',
        suffixIcon: IconButton(
            onPressed: onSend,
            splashRadius: 1,
            icon: Icon(
              Iconsax.send_2,
              color: Theme.of(context).iconTheme.color,
            )),

        hintStyle: TextStyle(
          color: Theme.of(context).textTheme.labelMedium!.color,
        ),
        //*Filled Color
        filled: true,
        fillColor: Theme.of(context).primaryColor,
        //*Enabled Border
        border: kLoginPageTextFormFieldOutlineInputBorder,
      ),
    ),
  );
}

//!input border style
InputBorder kLoginPageTextFormFieldOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(kTextFormFieldRadius),
  borderSide: BorderSide.none,
);
