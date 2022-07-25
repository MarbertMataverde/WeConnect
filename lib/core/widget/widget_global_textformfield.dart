import 'package:flutter/material.dart';

Widget globalTextFormField({
  required BuildContext context,
  double? textScaleFactor,
  TextInputType? textInputType,
  TextEditingController? controller,
  bool? isObscure,
  Widget? prefixIcon,
  Widget? passwordVisibilityIconButton,
  String? hint,
}) {
  return TextFormField(
    controller: controller,
    obscureText: isObscure ?? false,
    keyboardType: textInputType ?? TextInputType.text,
    cursorColor: Theme.of(context).textTheme.bodyMedium!.color,
    style: TextStyle(
      color: Theme.of(context).textTheme.bodyMedium!.color,
    ),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
          color: Theme.of(context).textTheme.bodyMedium!.color?.withAlpha(150)),
      filled: true,
      fillColor: const Color(0xff323645),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: BorderSide.none,
      ),
      prefixIcon: prefixIcon,
      suffixIcon: passwordVisibilityIconButton,
    ),
  );
}
