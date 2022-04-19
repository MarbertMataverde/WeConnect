import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giff_dialog/giff_dialog.dart';

import '../page/phone view/forgot password/forgot_password.dart';

class DialogAuthentication extends GetxController {
  //invalid account type
  Future<dynamic> invalidAccountTypeDialog(
    context,
    String assetLocation,
    String title,
    String description,
  ) async {
    showDialog(
      context: context,
      builder: (_) => AssetGiffDialog(
        onlyOkButton: true,
        buttonOkColor: Theme.of(context).primaryColor,
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

  //reset password dialog
  Future<dynamic> resetPasswordDialog(
    context,
    String assetLocation,
    String title,
    String description,
  ) async {
    showDialog(
      context: context,
      builder: (_) => AssetGiffDialog(
        onlyOkButton: true,
        buttonOkColor: Theme.of(context).primaryColor,
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
    context,
    String assetLocation,
    String title,
    String description,
  ) {
    return showDialog(
      context: context,
      builder: (_) => AssetGiffDialog(
        //? try again button
        buttonOkColor: Theme.of(context).primaryColor,

        //? reset button
        buttonCancelText: const Text(
          'Reset',
          style: TextStyle(color: Colors.white),
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
    context,
    String assetLocation,
    String title,
    String description,
  ) async {
    showDialog(
      context: context,
      builder: (_) => AssetGiffDialog(
        //? try again button
        buttonOkColor: Theme.of(context).primaryColor,
        buttonOkText: Text(
          'Try Again',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium!.color,
          ),
        ),
        onlyOkButton: true,
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
    context,
    String assetLocation,
    String title,
    String description,
  ) async {
    showDialog(
      context: context,
      builder: (_) => AssetGiffDialog(
        onlyOkButton: true,
        buttonOkColor: Theme.of(context).primaryColor,
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

  //something went wrong dialog
  Future<dynamic> somethingWentWrongDialog(
    context,
    String assetLocation,
    String title,
    String description,
  ) {
    return showDialog(
      context: context,
      builder: (_) => AssetGiffDialog(
        onlyOkButton: true,
        buttonOkColor: Theme.of(context).primaryColor,
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

  //welcome dialog
  Future<void> newUserWelcomeDialog({
    required BuildContext context,
    required String assetLocation,
    required String title,
    required String description,
  }) async {
    showDialog(
      context: context,
      builder: (_) => AssetGiffDialog(
        onlyOkButton: true,
        buttonOkColor: Theme.of(context).primaryColor,
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

  // email not verified dialog
  Future<void> emailNotVerified({
    required BuildContext context,
    required String assetLocation,
    required String title,
    required String description,
  }) async {
    showDialog(
      context: context,
      builder: (_) => AssetGiffDialog(
        onlyOkButton: true,
        buttonOkColor: Theme.of(context).primaryColor,
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
