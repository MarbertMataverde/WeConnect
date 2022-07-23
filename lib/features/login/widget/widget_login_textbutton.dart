import 'package:flutter/material.dart';
import 'package:weconnect/features/login/widget/widget_login_text.dart';

Widget loginTextButton({
  required BuildContext context,
  required String text,
  double? textScaleFactor,
}) {
  return SizedBox(
    width: double.infinity,
    height: 55,
    child: TextButton(
      onPressed: () {},
      child: globalLoginText(
        text: text,
        textScaleFactor: textScaleFactor,
        fontWeight: FontWeight.w400,
        color: Theme.of(context).primaryColor,
      ),
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(2),
          ),
        ),
        primary: Theme.of(context).primaryColor,
        backgroundColor: const Color(0xff323645),
      ),
    ),
  );
}

Widget loginForgotPassword({required BuildContext context}) {
  return Align(
    alignment: Alignment.centerRight,
    child: TextButton(
      onPressed: () {},
      child: globalLoginText(
        text: 'Forgot Password',
        fontWeight: FontWeight.w300,
      ),
      style: TextButton.styleFrom(
        primary: Theme.of(context).primaryColor,
      ),
    ),
  );
}

Widget loginCreate({required BuildContext context}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      globalLoginText(
        text: 'Dont have an account?',
        fontWeight: FontWeight.w300,
      ),
      TextButton(
        onPressed: () {},
        child: globalLoginText(
          text: 'Create',
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w300,
        ),
      ),
    ],
  );
}
