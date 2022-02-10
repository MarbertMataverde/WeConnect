import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/constant/constant.dart';
import 'package:weconnect/constant/constant_colors.dart';

import '../../widgets/widget_textformfield_login.dart';

final TextEditingController _emailCtrlr = TextEditingController();
final TextEditingController _passwordCtrlr = TextEditingController();

class WebView extends StatelessWidget {
  const WebView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: Get.mediaQuery.size.height,
        width: Get.mediaQuery.size.width * 0.3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                'Welcome Back Admin!',
                style: TextStyle(
                  color: Get.theme.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
            const Flexible(
              child: Text(
                'Please sign in to your account',
                style: TextStyle(fontSize: 15),
              ),
            ),
            SizedBox(height: 2.h),
            Form(
              child: Column(
                children: [
                  LoginPageTextFormField(
                    ctrlr: _emailCtrlr,
                    hint: 'Email',
                    isPassword: kFalse,
                  ),
                  SizedBox(height: 2.h),
                  LoginPageTextFormField(
                    ctrlr: _passwordCtrlr,
                    hint: 'Password',
                    isPassword: kTrue,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Forgot Password',
                  style: TextStyle(
                    color: Get.theme.primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 3.h),
            LoginButton(
              text: 'Sign In',
              textColor: Get.theme.primaryColor,
              bgColor: Get.isDarkMode
                  ? kTextFormFieldColorDarkTheme
                  : kTextFormFieldColorLightTheme,
            ),
            Row(
              children: [
                Flexible(
                  child: Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      color: Get.isDarkMode
                          ? kTextColorDarkTheme
                          : kTextColorLightTheme,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Get.theme.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.text,
    required this.textColor,
    this.bgColor,
    this.borderSide,
  }) : super(key: key);
  final String text;
  final Color textColor;
  final Color? bgColor;
  final BorderSide? borderSide;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 5.h,
      child: TextButton(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
          ),
        ),
        onPressed: () {},
        style: TextButton.styleFrom(
          side: borderSide,
          backgroundColor: bgColor,
          primary: Get.theme.primaryColor,
        ),
      ),
    );
  }
}
