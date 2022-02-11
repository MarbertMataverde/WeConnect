import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/auth/auth.dart';
import 'package:weconnect/constant/constant.dart';
import 'package:weconnect/constant/constant_colors.dart';
import 'package:weconnect/constant/constant_login_page.dart';

import '../../../../widgets/widget sign in/widget_custom_button.dart';
import '../../../../widgets/widget sign in/widget_textformfield_login.dart';

final TextEditingController _nameCtrlr = TextEditingController();
final TextEditingController _collegeOfCtrlr = TextEditingController();
final TextEditingController _studNumCtrlr = TextEditingController();
final TextEditingController _emailCtrlr = TextEditingController();
final TextEditingController _passwordCtrlr = TextEditingController();

final authentication = Get.put(Authentication());

//*LIST OF COLLEGES
final _collegeList = [
  'College of Accountancy',
  'College of Business',
  'College of Computer Studies',
  'Masteral',
];
String? _studentCollege;

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Get.theme.primaryColor,
          ),
        ),
        actions: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: Text(
                'Acess Code: $_accessCode',
                style: TextStyle(
                  color: Get.theme.primaryColor,
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
                'Student Sign Up',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Get.theme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Getting to know you 😎',
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Form(
                child: Column(
                  children: [
                    CustomTextFormField(
                      ctrlr: _nameCtrlr,
                      hint: 'Full Name',
                      isPassword: kFalse,
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Get.isDarkMode
                            ? kTextFormFieldColorDarkTheme
                            : kTextFormFieldColorLightTheme,
                        borderRadius:
                            BorderRadius.circular(kTextFormFieldRadius),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 3.w),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            iconSize: 20.sp,
                            dropdownColor: Get.isDarkMode
                                ? kTextFormFieldColorDarkTheme
                                : kTextFormFieldColorLightTheme,
                            icon: Icon(
                              Icons.arrow_drop_down,
                              color: Get.theme.primaryColor,
                            ),
                            value: _studentCollege,
                            hint: const Text(
                              'COA/COB/CCS/MASTERAL',
                            ),
                            items: _collegeList.map(buildMenuItem).toList(),
                            onChanged: (value) => setState(
                              () => _studentCollege = value,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // CustomTextFormField(
                    //   ctrlr: _collegeOfCtrlr,
                    //   hint: 'Contact Number',
                    //   isPassword: kFalse,
                    //   keyboardType: TextInputType.number,
                    // ),
                    SizedBox(height: 2.h),
                    CustomTextFormField(
                      ctrlr: _studNumCtrlr,
                      hint: 'Student Number',
                      isPassword: kFalse,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 2.h),
                    CustomTextFormField(
                      ctrlr: _emailCtrlr,
                      hint: 'Email Address',
                      isPassword: kFalse,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 2.h),
                    CustomTextFormField(
                      ctrlr: _passwordCtrlr,
                      hint: 'Password',
                      isPassword: kTrue,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 3.h),
              CustomButton(
                onPress: () async {},
                text: 'Create⚡',
                textColor: Get.theme.primaryColor,
                bgColor: Get.isDarkMode
                    ? kTextFormFieldColorDarkTheme
                    : kTextFormFieldColorLightTheme,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(
          color: Get.isDarkMode
              ? kTextFormFieldTextColorDarkTheme
              : kTextFormFieldTextColorLightTheme,
          fontWeight: FontWeight.w700,
          fontSize: 10.sp,
        ),
      ),
    );
