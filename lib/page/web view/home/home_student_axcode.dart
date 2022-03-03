import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../constant/constant.dart';
import '../../../constant/constant_colors.dart';

import '../../../authentication/authentication_controller.dart';
import '../../../utils/utils_xlsx_access_code_generator.dart';
import '../../../widgets/widget sign in/widget_custom_button.dart';
import '../../../widgets/widget sign in/widget_textformfield_login.dart';
import 'home_professor_axcode.dart';

const String _collectionName = 'student-access-code';
const String _studentAccessCodeFileName = 'GeneratedStudentsAccessCode';
final TextEditingController _studentAxCodeCtrlr = TextEditingController();

final authentication = Get.put(Authentication());
final xlsxAccessCodeGenerator = Get.put(XlsxAccessCodeGenerator());

// Validation Key
final _validationKey = GlobalKey<FormState>();

class StudentAxCodeGenerator extends StatefulWidget {
  const StudentAxCodeGenerator({
    Key? key,
  }) : super(key: key);

  @override
  State<StudentAxCodeGenerator> createState() => _StudentAxCodeGeneratorState();
}

class _StudentAxCodeGeneratorState extends State<StudentAxCodeGenerator> {
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
                key: _validationKey,
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
                        if (_isValid == true) {
                          await xlsxAccessCodeGenerator
                              .createAccessCodeExcelFile(
                            _collectionName,
                            _studentAxCodeCtrlr.text,
                            _studentAccessCodeFileName,
                          );
                        }
                        setState(() {
                          isLoading = false;
                        });
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
