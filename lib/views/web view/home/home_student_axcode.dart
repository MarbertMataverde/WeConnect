import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/constant/constant.dart';
import 'package:weconnect/constant/constant_colors.dart';

import '../../../auth/auth.dart';
import '../../../utils/xlsx_access_code_generator.dart';
import '../../../widgets/widget sign in/widget_custom_button.dart';
import '../../../widgets/widget sign in/widget_textformfield_login.dart';
import 'home_professor_axcode.dart';

const String _collectionName = 'student-access-code';
const String _studentAccessCodeFileName = 'GeneratedStudentsAccessCode';
final TextEditingController _studentAxCodeCtrlr = TextEditingController();

final authentication = Get.put(Authentication());
final xlsxAccessCodeGenerator = Get.put(XlsxAccessCodeGenerator());

class StudentAxCodeGenerator extends StatelessWidget {
  const StudentAxCodeGenerator({
    Key? key,
  }) : super(key: key);

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
                  'Generate Access Code',
                  style: TextStyle(
                    color: Get.theme.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
              const Flexible(
                child: Text(
                  'For Students',
                  style: TextStyle(
                    fontSize: 15,
                    height: 0.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Form(
                child: CustomTextFormField(
                  ctrlr: _studentAxCodeCtrlr,
                  hint: 'Number of access code..',
                  isPassword: kFalse,
                  inputFormater: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter The Number of Access Code For Students👨🏻‍💻';
                    }
                  },
                ),
              ),
              SizedBox(height: 3.h),
              CustomButton(
                onPress: () async {
                  xlsxAccessCodeGenerator.createAccessCodeExcelFile(
                      _collectionName,
                      _studentAxCodeCtrlr.text,
                      _studentAccessCodeFileName);
                },
                text: 'Generate',
                textColor: Get.theme.primaryColor,
                bgColor: Get.isDarkMode
                    ? kTextFormFieldColorDarkTheme
                    : kTextFormFieldColorLightTheme,
              ),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      'Not for students?',
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
                        Get.to(() => const ProfessorAxCodeGenerator());
                      },
                      child: Text(
                        'Professors',
                        style: TextStyle(
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
