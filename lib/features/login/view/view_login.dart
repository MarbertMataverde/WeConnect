import 'package:flutter/material.dart';
import 'package:weconnect/features/layout/layout_responsive.dart';
import 'package:weconnect/features/login/view/veiw.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      phone: LoginPhone(),
      tablet: LoginTablet(),
      desktop: LoginDesktop(),
    );
  }
}
