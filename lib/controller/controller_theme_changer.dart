import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControllerChangeTheme extends GetxController {
  void toggleChangeTheme() {
    if (Get.isDarkMode) {
      Get.changeTheme(ThemeData.light());
    } else {
      Get.changeTheme(ThemeData.dark());
    }
    update();
  }
}
