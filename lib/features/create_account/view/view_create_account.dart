import 'package:flutter/material.dart';
import 'package:weconnect/features/create_account/view/view.dart';
import 'package:weconnect/features/layout/layout_responsive.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      phone: CreateAccountPhone(),
      tablet: CreateAccountTablet(),
      desktop: CreateAccountDesktop(),
    );
  }
}
