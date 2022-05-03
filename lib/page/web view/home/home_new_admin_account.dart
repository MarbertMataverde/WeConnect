import 'package:flutter/material.dart';
import 'package:weconnect/widgets/text%20form%20field/custom_textformfield.dart';

class NewAdminAccount extends StatelessWidget {
  const NewAdminAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomTextFormField(
            isPassword: false,
            validator: (_) {},
            hint: 'Public Name: ex. MIS Admin',
          ),
          CustomTextFormField(
            isPassword: false,
            validator: (_) {},
            hint: 'Public Name: ex. MIS Admin',
          ),
        ],
      ),
    );
  }
}
