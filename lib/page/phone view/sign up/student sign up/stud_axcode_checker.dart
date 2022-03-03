import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../constant/constant.dart';
import '../../../../constant/constant_colors.dart';
import '../../../../constant/constant_login_page.dart';
import '../../../../utils/utils_access_code_checker.dart';

import '../../../../widgets/widget sign in/widget_custom_button.dart';
import '../../../../widgets/widget sign in/widget_textformfield_login.dart';
import '../professor sign up/prof_axcode_checker.dart';

final TextEditingController _axCodeCtrlr = TextEditingController();

final acessCodeChecker = Get.put(AccessCodeChecker());

// Validation Key
final _validationKey = GlobalKey<FormState>();

class StudentAxCodeChecker extends StatefulWidget {
  const StudentAxCodeChecker({
    Key? key,
  }) : super(key: key);

  @override
  State<StudentAxCodeChecker> createState() => _StudentAxCodeCheckerState();
}

class _StudentAxCodeCheckerState extends State<StudentAxCodeChecker> {
  //loading spinner
  bool isLoading = false;
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
                key: _validationKey,
                child: CustomTextFormField(
                  ctrlr: _axCodeCtrlr,
                  hint: 'Access Code',
                  isPassword: kFalse,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Access Code👨🏻‍💻';
                    }
                    return null;
                  },
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
                          await acessCodeChecker.studentAccessCodeChecker(
                            _axCodeCtrlr.text,
                            context,
                          );
                        }
                        setState(() {
                          isLoading = false;
                        });
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
