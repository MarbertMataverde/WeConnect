import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../../authentication/authentication_controller.dart';
import '../../../constant/constant.dart';

import '../../../controller/controller_account_information.dart';
import '../../../widgets/button/custom_button.dart';
import '../../../widgets/global spinkit/global_spinkit.dart';
import '../../../widgets/text form field/custom_textformfield.dart';
import '../forgot password/forgot_password.dart';
import '../sign up/student sign up/stud_axcode_checker.dart';

// Validation Key
final _validationKey = GlobalKey<FormState>();

final authentication = Get.put(Authentication());

// account type routing
final accountInfomation = Get.put(ControllerAccountInformation());

class PhoneViewSignIn extends StatefulWidget {
  const PhoneViewSignIn({
    Key? key,
  }) : super(key: key);

  @override
  State<PhoneViewSignIn> createState() => _PhoneViewSignInState();
}

class _PhoneViewSignInState extends State<PhoneViewSignIn> {
  bool isLoading = false;

  late TextEditingController _emailCtrlr;
  late TextEditingController _passwordCtrlr;

  @override
  void initState() {
    super.initState();
    _emailCtrlr = TextEditingController();
    _passwordCtrlr = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk').format(now);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          TextButton(
            onPressed: () {
              Get.to(() => const StudentAxCodeChecker());
            },
            child: Text(
              'SIGN UP',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
              Center(
                child: Image.asset(
                  'assets/app_icon/logo.png',
                  fit: BoxFit.cover,
                  height: 20.h,
                ),
              ),
              Text(
                // 'Hola 👋🏻',
                int.parse(formattedDate) >= 18 // 6PM
                    ? 'Good Evening!'
                    : int.parse(formattedDate) >= 12 && // 12 to 5PM
                            int.parse(formattedDate) <= 17
                        ? 'Good Afternoon!'
                        : 'Good Morning!',
                textScaleFactor: 2,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 1.h),
              const Text(
                'Enter your credentials to access your account.',
                textScaleFactor: 0.9,
              ),
              SizedBox(height: 1.h),
              Form(
                key: _validationKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      maxLine: 1,
                      ctrlr: _emailCtrlr,
                      hint: 'Email',
                      isPassword: kFalse,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        bool isEmailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value!);
                        if (value.isEmpty) {
                          return 'Please Enter Your Email 💌';
                        }
                        if (!isEmailValid) {
                          return 'Invalid Email 😐';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 2.h),
                    CustomTextFormField(
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
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    Get.to(() => const ForgotPassword());
                  },
                  child: Text(
                    'Forgot Password',
                    textScaleFactor: 0.9,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
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
                          await authentication.signIn(
                            _emailCtrlr.text,
                            _passwordCtrlr.text,
                            context,
                          );
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                      text: 'SIGN IN',
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
