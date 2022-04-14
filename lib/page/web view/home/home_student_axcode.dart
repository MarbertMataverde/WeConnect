import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../widgets/global%20spinkit/global_spinkit.dart';
import '../../../dialog/dialog_access_code_generator.dart';

import '../../../authentication/authentication_controller.dart';
import '../../../constant/constant.dart';
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
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.35,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Generate Access Code',
                textScaleFactor: 1.5,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'For Students',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
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
                  ? buildGlobalSpinkit(context: context)
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
                                'Are you sure you want to generate ${_studentAxCodeCtrlr.text} access code for students?',
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
                      text: 'GENERATE',
                    ),
              Row(
                children: [
                  const Text(
                    'Not for students?',
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const ProfessorAxCodeGenerator());
                    },
                    child: Text(
                      'Professors',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
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
