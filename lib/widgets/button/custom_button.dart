import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    this.borderSide,
    required this.onPress,
  }) : super(key: key);
  final String text;

  final BorderSide? borderSide;
  final dynamic onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: TextButton(
        onPressed: onPress,
        style: TextButton.styleFrom(
          side: borderSide,
          backgroundColor: Theme.of(context).primaryColor.withAlpha(30),
          primary: Theme.of(context).primaryColor,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
