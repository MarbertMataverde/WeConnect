import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';

FocusedMenuItem focusMenuItem(
  String title,
  IconData trailingIcon,
  Color iconColor,
  onPressed,
) {
  return FocusedMenuItem(
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.black,
      ),
    ),
    trailingIcon: Icon(
      trailingIcon,
      color: iconColor,
    ),
    onPressed: onPressed,
  );
}
