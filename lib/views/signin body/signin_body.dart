import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/constant/constant.dart';
import 'package:weconnect/views/web%20view/sign%20in/web_view.dart';

import '../phone view/sign in/phone_view.dart';

class SignInBody extends StatelessWidget {
  const SignInBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          //?phone view
          if (constraints.maxWidth < 768) {
            return const PhoneView();
          }
          //you can add layout for tablet too
          //?web view
          else {
            return const WebView();
          }
        },
      ),
    );
  }
}
