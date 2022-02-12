import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/constant/constant.dart';
import 'package:weconnect/constant/constant_colors.dart';
import 'package:weconnect/constant/constant_login_page.dart';
import 'package:weconnect/utils/access_code_checker.dart';

import '../../../../widgets/widget sign in/widget_custom_button.dart';
import '../../../../widgets/widget sign in/widget_textformfield_login.dart';

final TextEditingController _axCodeCtrlr = TextEditingController();

final acessCodeChecker = Get.put(AccessCodeChecker());

// Validation Key
final _validationKey = GlobalKey<FormState>();

class ProfessorAxCodeChecker extends StatefulWidget {
  const ProfessorAxCodeChecker({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfessorAxCodeChecker> createState() => _ProfessorAxCodeCheckerState();
}

class _ProfessorAxCodeCheckerState extends State<ProfessorAxCodeChecker> {
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
                'Professor Sign Up',
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
                          await acessCodeChecker.professorAccessCodeChecker(
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
            ],
          ),
        ),
      ),
    );
  }
}
