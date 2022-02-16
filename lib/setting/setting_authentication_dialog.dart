import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giff_dialog/giff_dialog.dart';

import '../constant/constant_colors.dart';
import '../views/phone view/forgot password/forgot_password.dart';

class SettingAuthenticationDialog extends GetxController {
  //reset password dialog
  Future<dynamic> resetPasswordDialog(
    _context,
    String assetLocation,
    String title,
    String description,
  ) async {
    showDialog(
      context: _context,
      builder: (_) => AssetGiffDialog(
        onlyOkButton: true,
        buttonOkColor: Get.theme.primaryColor,
        image: Image.asset(
          assetLocation,
          fit: BoxFit.cover,
        ),
        entryAnimation: EntryAnimation.bottom,
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
        ),
        description: Text(
          description,
          textAlign: TextAlign.center,
        ),
        onOkButtonPressed: () {
          Get.back();
        },
      ),
    );
  }

  //email already in use dialog
  Future<dynamic> emailAlreadyInUseDialog(
    _context,
    String assetLocation,
    String title,
    String description,
  ) {
    return showDialog(
      context: _context,
      builder: (_) => AssetGiffDialog(
        //? try again button
        buttonOkColor: Get.theme.primaryColor,

        //? reset button
        buttonCancelColor: Get.isDarkMode
            ? kTextFormFieldColorLightTheme
            : kTextFormFieldColorDarkTheme,
        buttonCancelText: Text(
          'Reset',
          style: TextStyle(
            color: Get.theme.primaryColor,
          ),
        ),
        onCancelButtonPressed: () {
          Get.back();
          Get.to(() => const ForgotPassword());
        },
        image: Image.asset(
          assetLocation,
          fit: BoxFit.cover,
        ),
        entryAnimation: EntryAnimation.bottom,
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
        ),
        description: Text(
          description,
          textAlign: TextAlign.center,
        ),
        onOkButtonPressed: () {
          Get.back();
        },
      ),
    );
  }

  //incorrect password dialog
  Future<dynamic> incorrectPasswordDialog(
    _context,
    String assetLocation,
    String title,
    String description,
  ) async {
    showDialog(
      context: _context,
      builder: (_) => AssetGiffDialog(
        //? try again button
        buttonOkColor: Get.theme.primaryColor,
        buttonOkText: Text(
          'Try Again',
          style: TextStyle(
            color: Get.isDarkMode
                ? kTextButtonColorDarkTheme
                : kTextButtonColorLightTheme,
          ),
        ),
        onlyOkButton: true,
        buttonCancelColor:
            Get.isDarkMode ? kButtonColorDarkTheme : kButtonColorLightTheme,
        image: Image.asset(
          assetLocation,
          fit: BoxFit.cover,
        ),
        entryAnimation: EntryAnimation.bottom,
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
        ),
        description: Text(
          description,
          textAlign: TextAlign.center,
        ),
        onOkButtonPressed: () {
          Get.back();
        },
      ),
    );
  }

  //user not found dialog
  Future<dynamic> userNotFoundDialog(
    _context,
    String assetLocation,
    String title,
    String description,
  ) async {
    showDialog(
      context: _context,
      builder: (_) => AssetGiffDialog(
        onlyOkButton: true,
        buttonOkColor: Get.theme.primaryColor,
        image: Image.asset(
          assetLocation,
          fit: BoxFit.cover,
        ),
        entryAnimation: EntryAnimation.bottom,
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
        ),
        description: Text(
          description,
          textAlign: TextAlign.center,
        ),
        onOkButtonPressed: () {
          Get.back();
        },
      ),
    );
  }

  //something went wrong dialog
  Future<dynamic> somethingWentWrongDialog(
    _context,
    String assetLocation,
    String title,
    String description,
  ) {
    return showDialog(
      context: _context,
      builder: (_) => AssetGiffDialog(
        onlyOkButton: true,
        buttonOkColor: Get.theme.primaryColor,
        image: Image.asset(
          assetLocation,
          fit: BoxFit.cover,
        ),
        entryAnimation: EntryAnimation.bottom,
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
        ),
        description: Text(
          description,
          textAlign: TextAlign.center,
        ),
        onOkButtonPressed: () {
          Get.back();
        },
      ),
    );
  }
}
