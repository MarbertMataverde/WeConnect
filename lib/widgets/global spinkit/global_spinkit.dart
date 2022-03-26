import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

SpinKitSquareCircle buildGlobalSpinkit({required BuildContext context}) {
  return SpinKitSquareCircle(
    color: Theme.of(context).primaryColor,
    size: MediaQuery.of(context).size.width * 0.1,
  );
}
