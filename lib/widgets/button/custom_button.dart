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
          foregroundColor: Colors.white,
          side: borderSide,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
