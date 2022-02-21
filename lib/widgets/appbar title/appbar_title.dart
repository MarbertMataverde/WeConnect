import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

//title colors
final colorizeColors = [
  Get.theme.primaryColor,
  Colors.yellow,
  Colors.cyan,
  Colors.red,
  Get.theme.primaryColor,
];

//title text style
final colorizeTextStyle = TextStyle(
  fontSize: 20.sp,
);

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.0,
      child: AnimatedTextKit(
        repeatForever: true,
        animatedTexts: [
          ColorizeAnimatedText(
            title,
            speed: const Duration(milliseconds: 200),
            textAlign: TextAlign.center,
            textStyle: colorizeTextStyle,
            colors: colorizeColors,
          ),
          ColorizeAnimatedText(
            'WeConnect',
            speed: const Duration(milliseconds: 300),
            textAlign: TextAlign.center,
            textStyle: colorizeTextStyle,
            colors: colorizeColors,
          ),
        ],
        isRepeatingAnimation: true,
        onTap: () {
          debugPrint("Tap Event");
        },
      ),
    );
  }
}
