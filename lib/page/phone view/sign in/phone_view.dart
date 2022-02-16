import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/authentication/authentication_controller.dart';
import 'package:weconnect/constant/constant.dart';
import 'package:weconnect/constant/constant_colors.dart';

import '../../../widgets/widget sign in/widget_custom_button.dart';
import '../../../widgets/widget sign in/widget_textformfield_login.dart';
import '../forgot password/forgot_password.dart';
import '../sign up/student sign up/stud_axcode_checker.dart';

final TextEditingController _emailCtrlr = TextEditingController();
final TextEditingController _passwordCtrlr = TextEditingController();

// Validation Key
final _validationKey = GlobalKey<FormState>();

final authentication = Get.put(Authentication());

class PhoneViewSignIn extends StatefulWidget {
  const PhoneViewSignIn({
    Key? key,
  }) : super(key: key);

  @override
  State<PhoneViewSignIn> createState() => _PhoneViewState();
}

class _PhoneViewState extends State<PhoneViewSignIn> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: () {
              Get.to(() => const StudentAxCodeChecker());
            },
            child: Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 12.sp,
                color: Get.theme.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: kPagePaddingHorizontal.w,
            right: kPagePaddingHorizontal.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Get.theme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Please sign in to your account',
                style: TextStyle(
                  fontSize: 12.sp,
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
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        bool _isEmailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!);
                        if (value.isEmpty) {
                          return 'Please Enter Your Email😊';
                        }
                        if (!_isEmailValid) {
                          return 'Invalid Email😐';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 2.h),
                    CustomTextFormField(
                      ctrlr: _passwordCtrlr,
                      hint: 'Password',
                      isPassword: kTrue,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Password🔐';
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
                  onPressed: () {
                    Get.to(() => const ForgotPassword());
                  },
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontSize: 10.sp,
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
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        print(sp.get('accountType'));

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
