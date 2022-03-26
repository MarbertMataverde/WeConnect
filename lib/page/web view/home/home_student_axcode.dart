import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../dialog/dialog_access_code_generator.dart';

import '../../../authentication/authentication_controller.dart';
import '../../../constant/constant.dart';
import '../../../constant/constant_colors.dart';
import '../../../widgets/button/custom_button.dart';
import '../../../widgets/text form field/custom_textformfield.dart';
import 'home_professor_axcode.dart';

const String _collectionName = 'student-access-code';
const String _studentAccessCodeFileName = 'GeneratedStudentsAccessCode';
final TextEditingController _studentAxCodeCtrlr = TextEditingController();

//dependencies
final dialog = Get.put(DialogAccessCodeGenerator());
final authentication = Get.put(Authentication());
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
                  maxCharLength: 4,
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
                          await dialog.accessCodeConfirmationDialog(
                            context,
                            assetLocation: 'assets/gifs/question_mark.gif',
                            title: 'Access Code Generation',
                            description:
                                'Are you sure you want to generate \n${_studentAxCodeCtrlr.text} access code for students?',
                            collectionName: _collectionName,
                            studentAxCodeCtrlr: _studentAxCodeCtrlr.text,
                            studentAccessCodeFileName:
                                _studentAccessCodeFileName,
                          );
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                      text: 'Generate',
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
