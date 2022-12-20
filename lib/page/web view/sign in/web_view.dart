import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/widgets/button/custom_text_button.dart';

import '../../../authentication/authentication_controller.dart';
import '../../../constant/constant.dart';
import '../../../widgets/button/custom_button.dart';
import '../../../widgets/global%20spinkit/global_spinkit.dart';
import '../../../widgets/text form field/custom_textformfield.dart';

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
  final TextEditingController _emailCtrlr = TextEditingController();
  final TextEditingController _passwordCtrlr = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.35,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Flexible(
                child: Text(
                  'Welcome Back Admin 👋🏻',
                  textScaleFactor: 2,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 1.h),
              const Text(
                'Enter your credentials to access your account.',
                textScaleFactor: 0.9,
              ),
              SizedBox(height: 2.h),
              Form(
                key: _validationKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      maxLine: 1,
                      ctrlr: _emailCtrlr,
                      hint: 'Email',
                      isPassword: kFalse,
                      validator: (value) {
                        bool isEmailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!);
                        if (value.isEmpty) {
                          return 'Please Enter Your Email 💌';
                        }
                        if (!isEmailValid) {
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
                child: customTextButton(onPress: () {}, label: 'Need Support?'),
              ),
              SizedBox(height: 3.h),
              isLoading
                  ? buildGlobalSpinkit(context: context, size: 30)
                  : CustomButton(
                      onPress: () async {
                        setState(() {
                          isLoading = true;
                        });
                        final isValid = _validationKey.currentState!.validate();
                        Get.focusScope!.unfocus();
                        if (isValid == true) {
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
                      text: 'SIGN IN',
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
