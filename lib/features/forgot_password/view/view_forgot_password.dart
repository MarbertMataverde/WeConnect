import 'package:flutter/material.dart';
import 'package:weconnect/features/forgot_password/view/view.dart';
import 'package:weconnect/features/layout/layout_responsive.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      phone: ForgotPasswordPhone(),
      tablet: ForgotPasswordTablet(),
      desktop: ForgotPasswordDesktop(),
    );
  }
}
