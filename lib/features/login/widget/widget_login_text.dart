import 'package:flutter/widgets.dart';

Widget globalLoginText({
  required String text,
  double? textScaleFactor,
  FontWeight? fontWeight,
  Color? color,
  TextAlign? textAlign,
}) {
  return Text(
    text,
    textAlign: textAlign,
    textScaleFactor: textScaleFactor ?? 1.0,
    style: TextStyle(fontWeight: fontWeight ?? FontWeight.normal, color: color),
  );
}
