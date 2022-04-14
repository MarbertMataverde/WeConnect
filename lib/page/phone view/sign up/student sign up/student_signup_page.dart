import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../../../widgets/appbar/build_appbar.dart';
import '../../../../widgets/global%20spinkit/global_spinkit.dart';
import '../../../../authentication/authentication_controller.dart';
import '../../../../constant/constant.dart';
import '../../../../constant/constant_login_page.dart';
import '../../../../widgets/button/custom_button.dart';
import '../../../../widgets/text form field/custom_textformfield.dart';

final authentication = Get.put(Authentication());

// Validation Key
final _validationKey = GlobalKey<FormState>();

//*LIST OF COLLEGES
final _collegeList = [
  'College of Accountancy',
  'College of Business',
  'College of Computer Studies',
  'Masteral',
];
String? _collegeOf;

//access code
final String _accessCode = Get.arguments.toString();

class StudentSignUpPage extends StatefulWidget {
  const StudentSignUpPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StudentSignUpPage> createState() => _StudentSignUpPageState();
}

class _StudentSignUpPageState extends State<StudentSignUpPage> {
  //loading spinner
  bool isLoading = false;
  //controllers
  final TextEditingController _nameCtrlr = TextEditingController();
  final TextEditingController _studNumCtrlr = TextEditingController();
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
                'Student Sign Up 👨🏻‍🎓',
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
                      hint: 'Full Name (LN, FN MI)',
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
                    Container(
                      height: 7.h,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withAlpha(15),
                        borderRadius:
                            BorderRadius.circular(kTextFormFieldRadius),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            iconSize: 20.sp,
                            dropdownColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Theme.of(context).primaryColor,
                            ),
                            value: _collegeOf,
                            hint: Text(
                              'COA/COB/CCS/MASTERAL',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .color),
                            ),
                            items: _collegeList
                                .map(
                                  buildMenuItem,
                                )
                                .toList(),
                            onChanged: (value) => setState(
                              () => _collegeOf = value,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    CustomTextFormField(
                      minimumLine: 1,
                      maxLine: 1,
                      ctrlr: _studNumCtrlr,
                      hint: 'Student Number',
                      isPassword: kFalse,
                      keyboardType: TextInputType.number,
                      inputFormater: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Student Number 😊';
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
                          return 'Password Should Be Longer or Equal to 8 characters👌';
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
                        //validation for colleges or masteral
                        if (_collegeOf == null) {
                          Get.defaultDialog(
                            content: Text(
                              'Please Select College 😉',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 9.sp,
                              ),
                            ),
                          );
                        }
                        if (_isValid == true && _collegeOf != null) {
                          await authentication.studentSignUp(
                            _accessCode,
                            _nameCtrlr.text,
                            _collegeOf.toString(),
                            int.parse(_studNumCtrlr.text),
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

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
            color: Theme.of(context).textTheme.labelMedium!.color,
          ),
        ),
      );
}
