import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

AppBar buildAppbarBackButton({required context}) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    leading: IconButton(
      onPressed: () {
        Get.back();
      },
      icon: Icon(
        Iconsax.arrow_square_left,
        color: Theme.of(context).iconTheme.color,
      ),
    ),
  );
}
