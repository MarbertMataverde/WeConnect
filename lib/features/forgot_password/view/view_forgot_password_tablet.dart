import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weconnect/core/widget/widget_global_text.dart';
import 'package:weconnect/core/widget/widget_global_textbutton.dart';
import 'package:weconnect/core/widget/widget_global_textformfield.dart';
import 'package:weconnect/features/layout/constant/constant_sizebox.dart';

class ForgotPasswordTablet extends StatelessWidget {
  const ForgotPasswordTablet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              globalText(text: 'Forgot your password?', textScaleFactor: 2),
              globalText(
                text:
                    'Enter your registered email below\nto receive password reset instruction',
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w100,
              ),
              sizedBox(height: 20),
              globalTextFormField(
                context: context,
                hint: 'Email Address',
                textInputType: TextInputType.emailAddress,
                prefixIcon: Icon(
                  Iconsax.sms,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
              ),
              sizedBox(height: 20),
              globalTextButton(
                context: context,
                text: 'Send',
              )
            ],
          ),
        ),
      ),
    );
  }
}
