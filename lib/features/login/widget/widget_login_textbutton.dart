import 'package:flutter/material.dart';
import 'package:weconnect/core/widget/widget_global_text.dart';
import 'package:weconnect/features/forgot_password/view/view_forgot_password.dart';

Widget loginForgotPassword({
  required BuildContext context,
}) {
  return Align(
    alignment: Alignment.centerRight,
    child: TextButton(
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (routeContext) => const ForgotPassword(),
        ),
      ),
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).primaryColor,
      ),
      child: globalText(
        text: 'Reset Password',
        fontWeight: FontWeight.w300,
      ),
    ),
  );
}

Widget loginCreate({required BuildContext context}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      globalText(
        text: 'Dont have an account?',
        fontWeight: FontWeight.w300,
      ),
      TextButton(
        onPressed: () {},
        child: globalText(
          text: 'Create',
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w300,
        ),
      ),
    ],
  );
}
