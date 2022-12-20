import 'package:flutter/material.dart';

Widget customTextButton({
  required Function()? onPress,
  required label,
}) {
  return TextButton(
    style: TextButton.styleFrom(foregroundColor: Colors.white),
    onPressed: onPress,
    child: Text(
      label,
    ),
  );
}
