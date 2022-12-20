import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../../widgets/appbar/appbar_back.dart';
import '../../../../constant/constant.dart';
import '../../../../utils/utils_access_code_checker.dart';
import '../../../../widgets/button/custom_button.dart';
import '../../../../widgets/global spinkit/global_spinkit.dart';
import '../../../../widgets/text form field/custom_textformfield.dart';

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
  //access cocde controller
  final TextEditingController _axCodeCtrlr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbarBackButton(context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: 2.h,
            left: kPagePaddingHorizontal.w,
            right: kPagePaddingHorizontal.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Professor Sign Up 👨🏻‍🏫',
                textScaleFactor: 1.7,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2.h),
              const Text(
                'Enter your access code to continue',
                textScaleFactor: 0.9,
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
                  ? buildGlobalSpinkit(context: context)
                  : CustomButton(
                      onPress: () async {
                        setState(() {
                          isLoading = true;
                        });
                        final isValid = _validationKey.currentState!.validate();
                        Get.focusScope!.unfocus();
                        if (isValid == true) {
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
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
