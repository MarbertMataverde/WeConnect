import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/constant/constant.dart';
import 'package:weconnect/constant/constant_colors.dart';
import 'package:weconnect/constant/constant_login_page.dart';
import 'package:weconnect/utils/access_code_checker.dart';
import 'package:weconnect/views/phone%20view/sign%20up/professor%20sign%20up/prof_axcode_checker.dart';

import '../../../../widgets/widget sign in/widget_custom_button.dart';
import '../../../../widgets/widget sign in/widget_textformfield_login.dart';

final TextEditingController _axCodeCtrlr = TextEditingController();

final acessCodeChecker = Get.put(AccessCodeChecker());

class StudentAxCodeChecker extends StatelessWidget {
  const StudentAxCodeChecker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kLoginLoginAppBarBackButton,
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
                'Student Sign Up',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Get.theme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Please type your access code to continue',
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Form(
                child: CustomTextFormField(
                  ctrlr: _axCodeCtrlr,
                  hint: 'Access Code',
                  isPassword: kFalse,
                ),
              ),
              SizedBox(height: 3.h),
              CustomButton(
                onPress: () async {
                  acessCodeChecker.studentAccessCodeChecker(_axCodeCtrlr.text);
                },
                text: 'Continue',
                textColor: Get.theme.primaryColor,
                bgColor: Get.isDarkMode
                    ? kTextFormFieldColorDarkTheme
                    : kTextFormFieldColorLightTheme,
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      'Sign up as',
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
                      onPressed: () {
                        Get.off(() => const ProfessorAxCodeChecker());
                      },
                      child: Text(
                        'Professor',
                        style: TextStyle(
                          fontSize: 10.sp,
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
      ),
    );
  }
}
