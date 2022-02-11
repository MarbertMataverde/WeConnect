import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/constant/constant.dart';
import 'package:weconnect/constant/constant_colors.dart';

import '../../../auth/auth.dart';
import '../../../utils/xlsx_access_code_generator.dart';
import '../../../widgets/widget sign in/widget_custom_button.dart';
import '../../../widgets/widget sign in/widget_textformfield_login.dart';

const String _collectionName = 'professor-access-code';
const String _professorAccessCodeFileName = 'GeneratedProfessorsAccessCode';
final TextEditingController _professorAxCodeCtrlr = TextEditingController();

final authentication = Get.put(Authentication());
final xlsxAccessCodeGenerator = Get.put(XlsxAccessCodeGenerator());

class ProfessorAxCodeGenerator extends StatelessWidget {
  const ProfessorAxCodeGenerator({
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
                  'For Professors',
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
                  ctrlr: _professorAxCodeCtrlr,
                  hint: 'Number of access code..',
                  isPassword: kFalse,
                ),
              ),
              SizedBox(height: 3.h),
              CustomButton(
                onPress: () async {
                  xlsxAccessCodeGenerator.createAccessCodeExcelFile(
                      _collectionName,
                      _professorAxCodeCtrlr.text,
                      _professorAccessCodeFileName);
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
                      'Go',
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
                        Get.back();
                      },
                      child: Text(
                        'Back',
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
