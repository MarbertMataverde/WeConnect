import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/constant/constant.dart';
import 'package:weconnect/constant/constant_colors.dart';

import '../../../authentication/authentication_controller.dart';
import '../../../widgets/widget sign in/widget_custom_button.dart';
import '../../../widgets/widget sign in/widget_textformfield_login.dart';

final TextEditingController _emailCtrlr = TextEditingController();
final TextEditingController _passwordCtrlr = TextEditingController();

// Validation Key
final _validationKey = GlobalKey<FormState>();

final authentication = Get.put(Authentication());

class WebView extends StatefulWidget {
  const WebView({
    Key? key,
  }) : super(key: key);

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                key: _validationKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      ctrlr: _emailCtrlr,
                      hint: 'Email',
                      isPassword: kFalse,
                      validator: (value) {
                        bool _isEmailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!);
                        if (value.isEmpty) {
                          return 'Please Enter Your Email 😊';
                        }
                        if (!_isEmailValid) {
                          return 'Invalid Email 😐';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 2.h),
                    CustomTextFormField(
                      maxLine: 1,
                      ctrlr: _passwordCtrlr,
                      hint: 'Password',
                      isPassword: kTrue,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Password 🔐';
                        }
                        if (value.toString().length < 8) {
                          return 'Password Should Be Longer or Equal to 8 characters👌';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Need Support 👨‍💻',
                    style: TextStyle(
                      color: Get.theme.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              isLoading
                  ? SpinKitSpinningLines(
                      color: Get.theme.primaryColor,
                      lineWidth: 1,
                      itemCount: 5,
                      size: 50,
                    )
                  : CustomButton(
                      onPress: () async {
                        setState(() {
                          isLoading = true;
                        });
                        final _isValid =
                            _validationKey.currentState!.validate();
                        Get.focusScope!.unfocus();
                        if (_isValid == true) {
                          await authentication.signIn(
                            _emailCtrlr.text,
                            _passwordCtrlr.text,
                            context,
                          );
                        }

                        setState(() {
                          isLoading = false;
                        });
                      },
                      text: 'Sign In',
                      textColor: Get.theme.primaryColor,
                      bgColor: Get.isDarkMode
                          ? kTextFormFieldColorDarkTheme
                          : kTextFormFieldColorLightTheme,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
