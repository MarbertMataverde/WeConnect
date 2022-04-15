import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

SpinKitFadingCircle buildGlobalSpinkit({required BuildContext context}) {
  return SpinKitFadingCircle(
    color: Theme.of(context).primaryColor,
    size: MediaQuery.of(context).size.width * 0.08,
  );
}
