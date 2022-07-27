import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weconnect/core/widget/widget_global_dropdownbuttonformfield.dart';
import 'package:weconnect/core/widget/widget_global_text.dart';
import 'package:weconnect/core/widget/widget_global_textformfield.dart';
import 'package:weconnect/features/create_account/widget/widget_controllerbuilder.dart';
import 'package:weconnect/features/layout/constant/constant_sizebox.dart';

int _currentStep = 0;

late bool _isPasswordVisible;

bool? _isSubmitEnabled = false;

/// List of college dropdown menu items
List<String> _colleges = ['COA', 'COB', 'CCS'];

/// Current [_colleges] selected item
String? _collegeSelectedItem;

/// List of gender dropdown menu items
List<String> _genders = ['Male', 'Female', 'Others'];

/// Current [_gender] selected item
String? _genderSelectedItem;

DateTime _birthDate = (DateTime(2000, 01, 17));

/// List of account type
List<String> _accountTypes = [
  'Account Type: Student',
  'Account Type: Professor'
];

/// Current [_accountTypes] selected item is Student
String? _accountTypeSelectedItem = 'Account Type: Student';

class CreateAccountTablet extends StatefulWidget {
  const CreateAccountTablet({Key? key}) : super(key: key);

  @override
  State<CreateAccountTablet> createState() => _CreateAccountDesktopState();
}

class _CreateAccountDesktopState extends State<CreateAccountTablet> {
  @override
  void initState() {
    super.initState();
    _isPasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              globalText(
                text: 'Set up your WeConnect account',
                textScaleFactor: 1.7,
                fontWeight: FontWeight.w600,
              ),
              Stepper(
                currentStep: _currentStep,
                onStepContinue: () {
                  if (_currentStep != 3) {
                    setState(() => _currentStep++);
                  }
                },
                onStepCancel: () {
                  if (_currentStep != 0) {
                    setState(() => _currentStep--);
                  }
                },
                onStepTapped: (step) {
                  setState(() => _currentStep = step);
                },
                controlsBuilder: (context, details) {
                  return buildControlsBuilder(
                    context: context,
                    details: details,
                    onSubmit: () {},
                    enableSubmitButton: _isSubmitEnabled,
                  );
                },
                steps: <Step>[
                  Step(
                    isActive: _currentStep >= 0,
                    title: globalText(text: 'Personal Information'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              width: mediaQueryWidth * 0.40,
                              child: globalTextFormField(
                                  context: context, hint: 'First Name'),
                            ),
                            sizedBox(height: 20),
                            SizedBox(
                              width: mediaQueryWidth * 0.40,
                              child: globalTextFormField(
                                  context: context, hint: 'Middle Name'),
                            ),
                            sizedBox(height: 20),
                            SizedBox(
                              width: mediaQueryWidth * 0.40,
                              child: globalTextFormField(
                                  context: context, hint: 'Last Name'),
                            ),
                          ],
                        ),
                        sizedBox(height: 20),
                        Row(
                          children: [
                            SizedBox(
                              width: mediaQueryWidth * 0.40,
                              child: globalTextFormField(
                                context: context,
                                hint: 'Adress',
                              ),
                            ),
                            SizedBox(
                              width: mediaQueryWidth * 0.020,
                            ),
                            SizedBox(
                              width: mediaQueryWidth * 0.25,
                              child: globalDropdownButtonFormField(
                                context: context,
                                hintText: 'Gender',
                                value: _genderSelectedItem,
                                items: _genders
                                    .map(
                                      (gender) => DropdownMenuItem(
                                        value: gender,
                                        child: globalText(text: gender),
                                      ),
                                    )
                                    .toList(),
                                onChange: (gender) => setState(
                                    () => _genderSelectedItem = gender),
                              ),
                            ),
                          ],
                        ),
                        sizedBox(height: 20),
                        Row(
                          children: [
                            SizedBox(
                              width: mediaQueryWidth * 0.30,
                              height: 50,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xff323645),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                                child: Center(
                                  child: Text(
                                    'Birthdate:  ${_birthDate.month}-${_birthDate.day}-${_birthDate.year}',
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              splashRadius: 24,
                              icon: const Icon(Iconsax.calendar_1),
                              onPressed: () async {
                                DateTime? newBirthDate = await showDatePicker(
                                  helpText: 'Birthdate',
                                  context: context,
                                  initialDate: _birthDate,
                                  firstDate: DateTime(1940),
                                  lastDate: DateTime(2040),
                                );

                                if (newBirthDate == null) return;
                                setState(() => _birthDate = newBirthDate);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Step(
                    isActive: _currentStep >= 1,
                    title: globalText(text: 'Account Information'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: mediaQueryWidth * 0.40,
                          child: globalDropdownButtonFormField(
                            context: context,
                            value: _accountTypeSelectedItem,
                            items: _accountTypes
                                .map(
                                  (accountType) => DropdownMenuItem(
                                    value: accountType,
                                    child: globalText(text: accountType),
                                  ),
                                )
                                .toList(),
                            onChange: (accountType) => setState(
                                () => _accountTypeSelectedItem = accountType),
                          ),
                        ),
                        sizedBox(height: 20),
                        Visibility(
                          visible: _accountTypeSelectedItem ==
                              'Account Type: Student',
                          replacement: Row(
                            children: [
                              SizedBox(
                                width: mediaQueryWidth * 0.30,
                                child: globalTextFormField(
                                    context: context, hint: 'Employee Number'),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: mediaQueryWidth * 0.30,
                                child: globalTextFormField(
                                    context: context, hint: 'Student Number'),
                              ),
                              SizedBox(
                                width: mediaQueryWidth * 0.020,
                              ),
                              SizedBox(
                                width: mediaQueryWidth * 0.30,
                                child: globalDropdownButtonFormField(
                                  context: context,
                                  hintText: 'College',
                                  value: _collegeSelectedItem,
                                  items: _colleges
                                      .map(
                                        (college) => DropdownMenuItem(
                                          value: college,
                                          child: globalText(text: college),
                                        ),
                                      )
                                      .toList(),
                                  onChange: (college) => setState(
                                      () => _collegeSelectedItem = college),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Step(
                    isActive: _currentStep >= 2,
                    title: globalText(text: 'Login Information'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: mediaQueryWidth * 0.30,
                          child: globalTextFormField(
                            context: context,
                            hint: 'Email Address',
                          ),
                        ),
                        sizedBox(height: 20),
                        Row(
                          children: [
                            SizedBox(
                              width: mediaQueryWidth * 0.30,
                              child: globalTextFormField(
                                context: context,
                                hint: 'Password',
                                textInputType: TextInputType.visiblePassword,
                                textScaleFactor: 1.2,
                                isObscure: !_isPasswordVisible,
                                passwordVisibilityIconButton: IconButton(
                                  splashRadius: 0.1,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color,
                                  onPressed: () => setState(
                                    () => _isPasswordVisible =
                                        !_isPasswordVisible,
                                  ),
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Iconsax.eye
                                        : Iconsax.eye_slash,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: mediaQueryWidth * 0.020,
                            ),
                            SizedBox(
                              width: mediaQueryWidth * 0.30,
                              child: globalTextFormField(
                                context: context,
                                hint: 'Confirm Password',
                                textInputType: TextInputType.visiblePassword,
                                textScaleFactor: 1.2,
                                isObscure: !_isPasswordVisible,
                                passwordVisibilityIconButton: IconButton(
                                  splashRadius: 0.1,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .color,
                                  onPressed: () => setState(
                                    () => _isPasswordVisible =
                                        !_isPasswordVisible,
                                  ),
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Iconsax.eye
                                        : Iconsax.eye_slash,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Step(
                    isActive: _currentStep >= 3,
                    title: globalText(text: 'Access Code Checker'),
                    subtitle: globalText(
                        text:
                            'To complete account creation we need to check if your access code is valid'),
                    content: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: mediaQueryWidth * 0.30,
                              child: globalTextFormField(
                                context: context,
                                hint: 'Access Code',
                              ),
                            ),
                            IconButton(
                              tooltip: 'Check now',
                              splashRadius: 24,
                              icon: const Icon(Iconsax.search_status),
                              onPressed: () {
                                setState(() {
                                  _isSubmitEnabled = true;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
