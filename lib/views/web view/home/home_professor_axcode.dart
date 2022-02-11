import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

// Validation Key
final _validationKey = GlobalKey<FormState>();

class ProfessorAxCodeGenerator extends StatefulWidget {
  const ProfessorAxCodeGenerator({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfessorAxCodeGenerator> createState() =>
      _ProfessorAxCodeGeneratorState();
}

class _ProfessorAxCodeGeneratorState extends State<ProfessorAxCodeGenerator> {
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
                key: _validationKey,
                child: CustomTextFormField(
                  ctrlr: _professorAxCodeCtrlr,
                  hint: 'Number of access code..',
                  isPassword: kFalse,
                  inputFormater: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter The Number of Access Code For Professors👨🏻‍💻';
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
                            _professorAxCodeCtrlr.text,
                            _professorAccessCodeFileName,
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
