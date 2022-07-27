import 'package:flutter/widgets.dart';

/// This is a global SizeBox that has a default value height of 10
SizedBox sizedBox({double? height}) {
  return SizedBox(
    height: height ?? 10,
  );
}
