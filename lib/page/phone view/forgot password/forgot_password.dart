import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../../widgets/appbar/build_appbar.dart';
import '../../../widgets/global%20spinkit/global_spinkit.dart';
import '../../../authentication/authentication_controller.dart';
import '../../../constant/constant.dart';
import '../../../widgets/button/custom_button.dart';
import '../../../widgets/text form field/custom_textformfield.dart';

// Validation Key
final _validationKey = GlobalKey<FormState>();

final authentication = Get.put(Authentication());

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({
    Key? key,
  }) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool isLoading = false;
  //controller
  late TextEditingController _emailCtrlr;

  @override
  void initState() {
    super.initState();
    _emailCtrlr = TextEditingController();
  }

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Forgot',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp,
                    ),
                  ),
                  Text(
                    'Your Password 🤔',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 18.sp,
                      height: 0.9,
                    ),
                  ),
                ],
              ),
              Center(
                child: Image.asset(
                  'assets/vectors/forgot_password.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Center(
                child: Text(
                  'Enter your email address and we will\nsend you a link to reset your\npassword! 😉',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.labelMedium!.color,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Form(
                key: _validationKey,
                child: CustomTextFormField(
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
                      return 'Please Enter Your Email😊';
                    }
                    if (!_isEmailValid) {
                      return 'Invalid Email😐';
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
                        final _isValid =
                            _validationKey.currentState!.validate();
                        Get.focusScope!.unfocus();
                        if (_isValid == true) {
                          await authentication.resetPassword(
                            _emailCtrlr.text,
                            context,
                          );

                          _emailCtrlr.clear();
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                      text: 'Reset Now ⚡',
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
