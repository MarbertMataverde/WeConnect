import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../constant/constant_colors.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class ControllerReport extends GetxController {
  Future announcementReport({
    required reportType,
    required reportConcern,
    required reportConcernDescription,
    required reportDocummentId,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await firestore.collection('reports').doc('announcement-report').set({
      'reported-at': Timestamp.now(),
      'reporter-profile-image-url':
          sharedPreferences.get('currentProfileImageUrl'),
      'reporter-name': sharedPreferences.get('currentProfileName'),
      'reporter-account-type': sharedPreferences.get('accountType'),
      'report-concern': reportConcern,
      'report-concern-description': reportConcernDescription,
      'post-documment-id': reportDocummentId,
      'report-type': reportType,
    });
  }

  Future dismissReport({
    required context,
    required String reportDocId,
    required String title,
    required String assetLocation,
    required String description,
  }) async {
    showDialog(
      context: context,
      builder: (_) => AssetGiffDialog(
        buttonOkColor: Get.theme.primaryColor,
        buttonOkText: Text(
          'Yes',
          style: TextStyle(
            color: Get.theme.textTheme.button!.color,
          ),
        ),
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
        onOkButtonPressed: () async {
          await firestore.collection('reports').doc(reportDocId).delete();
          Get.back();
          Get.back();
          Get.showSnackbar(
            GetSnackBar(
              icon: Icon(
                MdiIcons.checkBold,
                color: Get.theme.primaryColor,
              ),
              margin: EdgeInsets.all(2.w),
              borderRadius: 1.w,
              backgroundColor: kButtonColorLightTheme,
              message: 'Success report has been dismiss.',
              duration: const Duration(seconds: 1),
              forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
            ),
          );
        },
      ),
    );
  }
}
