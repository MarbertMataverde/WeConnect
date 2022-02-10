import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/constant/constant.dart';
import 'package:weconnect/views/web%20view/web_view.dart';

import '../phone view/phone_view.dart';

class AuthBody extends StatelessWidget {
  const AuthBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          //?phone view
          if (constraints.maxWidth < 768) {
            return Padding(
              padding: EdgeInsets.only(
                top: kPagePaddingVertial.h,
                left: kPagePaddingHorizontal.w,
                right: kPagePaddingHorizontal.w,
              ),
              child: const SingleChildScrollView(child: PhoneView()),
            );
          }
          //you can add layout for tablet too
          //?web view
          else {
            return const WebView();
          }
        }),
      ),
    );
  }
}
