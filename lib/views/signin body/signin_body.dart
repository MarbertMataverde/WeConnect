import 'package:flutter/material.dart';
import 'package:weconnect/views/web%20view/home/home_web_wrapper.dart';

import '../phone view/home/home_phone_wrapper.dart';
import '../phone view/sign in/phone_view.dart';
import '../web view/home/home_student_axcode.dart';
import '../web view/sign in/web_view.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({
    Key? key,
    required this.isSignedIn,
  }) : super(key: key);

  final bool isSignedIn;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          //?phone view
          if (constraints.maxWidth < 768) {
            return isSignedIn
                ? const HomePhoneWrapper()
                : const PhoneViewSignIn();
          }
          //you can add layout for tablet too
          //?web view
          else {
            return isSignedIn ? const HomeWebWrapper() : const WebView();
          }
        },
      ),
    );
  }
}
