import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/widgets/appbar/build_appbar.dart';
import '../../../../authentication/authentication_controller.dart';
import '../../../../constant/constant.dart';
import '../../../../widgets/button/custom_button.dart';
import '../../../../widgets/global spinkit/global_spinkit.dart';
import '../../../../widgets/text form field/custom_textformfield.dart';

final authentication = Get.put(Authentication());

// Validation Key
final _validationKey = GlobalKey<FormState>();

//access code
final String _accessCode = Get.arguments.toString();

class ProfessorSignUpPage extends StatefulWidget {
  const ProfessorSignUpPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfessorSignUpPage> createState() => _ProfessorSignUpPageState();
}

class _ProfessorSignUpPageState extends State<ProfessorSignUpPage> {
  //loading spinner
  bool isLoading = false;
  //controllers
  final TextEditingController _nameCtrlr = TextEditingController();
  final TextEditingController _contNumCtrlr = TextEditingController();
  final TextEditingController _employeeNumCtrlr = TextEditingController();
  final TextEditingController _emailCtrlr = TextEditingController();
  final TextEditingController _passwordCtrlr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: '',
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Iconsax.arrow_square_left,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: Text(
                'Acess Code: $_accessCode',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
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
                'Professor Sign Up 👨🏻‍🏫',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Getting to know you 😎',
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 1.h),
              Form(
                key: _validationKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      minimumLine: 1,
                      maxLine: 1,
                      ctrlr: _nameCtrlr,
                      hint: 'Full Name',
                      isPassword: kFalse,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Your Beautiful Name 🤗';
                        }
                        if (value.toString().length <= 2) {
                          return 'Please Enter Your Full Name 😉';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 2.h),
                    CustomTextFormField(
                      minimumLine: 1,
                      maxLine: 1,
                      ctrlr: _contNumCtrlr,
                      hint: 'Contact Number',
                      isPassword: kFalse,
                      keyboardType: TextInputType.number,
                      inputFormater: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      validator: (value) {
                        if (value.toString().length <= 10 &&
                            value.isEmpty == false) {
                          return 'Please Enter A Valid PH Contact Number 📞';
                        }
                        if (value.isEmpty) {
                          return 'Enter Contact Number 😊';
                        }
                      },
                    ),
                    SizedBox(height: 2.h),
                    CustomTextFormField(
                      minimumLine: 1,
                      maxLine: 1,
                      ctrlr: _employeeNumCtrlr,
                      hint: 'Employee Number',
                      isPassword: kFalse,
                      keyboardType: TextInputType.number,
                      inputFormater: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Employee Number 😊';
                        }
                      },
                    ),
                    SizedBox(height: 5.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'This what you will use to sign in 🔐',
                        style: TextStyle(
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    CustomTextFormField(
                      minimumLine: 1,
                      maxLine: 1,
                      ctrlr: _emailCtrlr,
                      hint: 'Email Address',
                      isPassword: kFalse,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        bool _isEmailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!);
                        if (value.isEmpty) {
                          return 'Please Enter Your Email 😊';
                        }
                        if (!_isEmailValid) {
                          return 'Invalid Email 😐';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 2.h),
                    CustomTextFormField(
                      minimumLine: 1,
                      maxLine: 1,
                      ctrlr: _passwordCtrlr,
                      hint: 'Password',
                      isPassword: kTrue,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please Enter Password 🔐';
                        }
                        if (value.toString().length < 8) {
                          return 'Password Should Be Longer or Equal to 8 characters 👌';
                        }
                        return null;
                      },
                    ),
                  ],
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
                        Get.focusScope!.unfocus();
                        if (_isValid == true) {
                          await authentication.professorSignUp(
                            _accessCode,
                            _nameCtrlr.text,
                            int.parse(_contNumCtrlr.text),
                            int.parse(_employeeNumCtrlr.text),
                            _emailCtrlr.text,
                            _passwordCtrlr.text,
                            context,
                          );
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                      text: 'Create⚡',
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
