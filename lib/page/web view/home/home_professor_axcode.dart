import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../widgets/global%20spinkit/global_spinkit.dart';
import '../../../constant/constant.dart';

import '../../../authentication/authentication_controller.dart';
import '../../../dialog/dialog_access_code_generator.dart';
import '../../../widgets/button/custom_button.dart';
import '../../../widgets/text form field/custom_textformfield.dart';

const String _collectionName = 'professor-access-code';
const String _professorAccessCodeFileName = 'GeneratedProfessorsAccessCode';
final TextEditingController _professorAxCodeCtrlr = TextEditingController();

//dependencies
final dialog = Get.put(DialogAccessCodeGenerator());
final authentication = Get.put(Authentication());

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
                'For Professors',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2.h),
              Form(
                key: _validationKey,
                child: CustomTextFormField(
                  ctrlr: _professorAxCodeCtrlr,
                  hint: 'Number of access code..',
                  maxCharLength: 4,
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
                                'Are you sure you want to generate ${_professorAxCodeCtrlr.text} access code for professors?',
                            collectionName: _collectionName,
                            studentAxCodeCtrlr: _professorAxCodeCtrlr.text,
                            studentAccessCodeFileName:
                                _professorAccessCodeFileName,
                          );
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                      text: 'GENERATE',
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
