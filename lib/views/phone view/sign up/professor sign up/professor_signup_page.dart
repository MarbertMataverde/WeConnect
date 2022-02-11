import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/auth/auth.dart';
import 'package:weconnect/constant/constant.dart';
import 'package:weconnect/constant/constant_colors.dart';

import '../../../../widgets/widget sign in/widget_custom_button.dart';
import '../../../../widgets/widget sign in/widget_textformfield_login.dart';

final TextEditingController _nameCtrlr = TextEditingController();
final TextEditingController _contNumCtrlr = TextEditingController();
final TextEditingController _employeeNumCtrlr = TextEditingController();
final TextEditingController _emailCtrlr = TextEditingController();
final TextEditingController _passwordCtrlr = TextEditingController();

final authentication = Get.put(Authentication());

//access code
final String _accessCode = Get.arguments.toString();

class ProfessorSignUpPage extends StatelessWidget {
  const ProfessorSignUpPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Get.theme.primaryColor,
          ),
        ),
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: Text(
                'Acess Code: $_accessCode',
                style: TextStyle(
                  color: Get.theme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
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
                'Professor Sign Up',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Get.theme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Getting to know you 😎',
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Form(
                child: Column(
                  children: [
                    CustomTextFormField(
                      ctrlr: _nameCtrlr,
                      hint: 'Full Name',
                      isPassword: kFalse,
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 2.h),
                    CustomTextFormField(
                      ctrlr: _contNumCtrlr,
                      hint: 'Contact Number',
                      isPassword: kFalse,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 2.h),
                    CustomTextFormField(
                      ctrlr: _employeeNumCtrlr,
                      hint: 'Student Number',
                      isPassword: kFalse,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 2.h),
                    CustomTextFormField(
                      ctrlr: _emailCtrlr,
                      hint: 'Email Address',
                      isPassword: kFalse,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 2.h),
                    CustomTextFormField(
                      ctrlr: _passwordCtrlr,
                      hint: 'Password',
                      isPassword: kTrue,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.h),
              CustomButton(
                onPress: () async {},
                text: 'Create⚡',
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
