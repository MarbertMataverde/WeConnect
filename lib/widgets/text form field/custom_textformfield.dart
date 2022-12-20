import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constant/constant.dart';
import '../../constant/constant_login_page.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.ctrlr,
    this.hint,
    this.isPassword,
    this.keyboardType,
    required this.validator,
    this.inputFormater,
    this.minimumLine,
    this.maxLine,
    this.autovalidateMode,
    this.onChanged,
    this.suffixWidget,
    this.inputAction,
    this.maxCharLength,
    this.initialValue,
    this.isEnable,
    this.disableColor,
  }) : super(key: key);
  //?controller
  final TextEditingController? ctrlr;
  //?hint
  final String? hint;
  //?it is password or not
  final bool? isPassword;
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
  //?suffix widget
  final Widget? suffixWidget;
  final TextInputAction? inputAction;
  // max char length of the text field
  final int? maxCharLength;
  final String? initialValue;
  //is disable
  final bool? isEnable;
  // disable color
  final Color? disableColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: isEnable,
      initialValue: initialValue,
      textInputAction: inputAction,
      minLines: minimumLine,
      maxLines: maxLine,
      maxLength: maxCharLength,
      validator: validator,
      inputFormatters: inputFormater,
      keyboardType: keyboardType,
      controller: ctrlr,
      obscureText: isPassword ?? false,
      autovalidateMode: autovalidateMode,
      onChanged: onChanged,
      style: TextStyle(
        color: Theme.of(context).textTheme.labelMedium!.color,
      ),
      cursorColor: Theme.of(context).textTheme.labelMedium!.color,
      decoration: InputDecoration(
        errorStyle: TextStyle(
          color: Theme.of(context).errorColor,
        ),
        suffixIcon: suffixWidget,
        filled: kTrue,
        fillColor: disableColor ?? Theme.of(context).primaryColor,
        hintText: hint,
        hintStyle:
            TextStyle(color: Theme.of(context).textTheme.labelMedium!.color),
        border: kLoginPageTextFormFieldOutlineInputBorder,
      ),
    );
  }
}

//!input border style
InputBorder kLoginPageTextFormFieldOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(kTextFormFieldRadius),
  borderSide: BorderSide.none,
);
