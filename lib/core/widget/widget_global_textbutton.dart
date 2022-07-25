import 'package:flutter/material.dart';
import 'package:weconnect/core/widget/widget_global_text.dart';

Widget globalTextButton({
  required BuildContext context,
  required String text,
  double? textScaleFactor,
  Function()? onPressed,
}) {
  return SizedBox(
    width: double.infinity,
    height: 55,
    child: TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(2),
          ),
        ),
        primary: Theme.of(context).primaryColor,
        backgroundColor: const Color(0xff323645),
      ),
      child: globalText(
        text: text,
        textScaleFactor: textScaleFactor,
        fontWeight: FontWeight.w400,
        color: Theme.of(context).primaryColor,
      ),
    ),
  );
}
