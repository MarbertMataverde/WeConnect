import 'package:flutter/material.dart';

buildAppBar({
  required context,
  String? title,
  List<Widget>? actions,
  Widget? leading,
  bool? autoLeading,
}) {
  return AppBar(
    automaticallyImplyLeading: autoLeading ?? false,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    leading: leading,
    title: Text(
      title ?? '',
      textScaleFactor: 1.3,
    ),
    actions: actions,
  );
}
