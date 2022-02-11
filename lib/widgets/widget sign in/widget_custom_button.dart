import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.textColor,
    this.bgColor,
    this.borderSide,
    required this.onPress,
  }) : super(key: key);
  final String text;
  final Color textColor;
  final Color? bgColor;
  final BorderSide? borderSide;
  final dynamic onPress;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: TextButton(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
          ),
        ),
        onPressed: onPress,
        style: TextButton.styleFrom(
          side: borderSide,
          backgroundColor: bgColor,
          primary: Get.theme.primaryColor,
        ),
      ),
    );
  }
}
