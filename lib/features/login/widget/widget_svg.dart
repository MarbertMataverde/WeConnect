import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget svgAssetLogo({
  required String assetPath,
  required double width,
}) =>
    SvgPicture.asset(
      assetPath,
      semanticsLabel: 'WeConnect Logo',
      width: width,
    );
