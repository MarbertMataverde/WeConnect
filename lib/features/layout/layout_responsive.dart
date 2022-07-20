import 'package:flutter/material.dart';
import 'package:weconnect/features/layout/constant/constant_screen_sizes.dart';

class Responsive extends StatelessWidget {
  const Responsive({
    Key? key,
    required this.phone,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);

  final Widget phone;
  final Widget tablet;
  final Widget desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth <= phoneSize) {
          return phone;
        } else if (constraints.maxWidth >= tabletSize ||
            constraints.maxWidth <= tabletBreakPointSize) {
          return tablet;
        } else {
          return desktop;
        }
      },
    );
  }
}
