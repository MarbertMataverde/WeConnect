import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weconnect/widgets/snakbar/snakbar.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class ControllerReport extends GetxController {
  Future announcementReport({
    required reportType,
    required reportConcern,
    required reportConcernDescription,
    required reportDocummentId,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await firestore
        .collection('reports')
        .doc('announcement-report')
        .collection('reports')
        .doc()
        .set({
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

  // announcement report dismissal
  Future dismissReport({
    required context,
    required String reportDocId,
    required String title,
    required String assetLocation,
    required String description,
    required String reportDocType,
  }) async {
    showDialog(
      context: context,
      builder: (_) => AssetGiffDialog(
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
        onOkButtonPressed: () async {
          await firestore
              .collection('reports')
              .doc(reportDocType)
              .collection('reports')
              .doc(reportDocId)
              .delete();
          Get.back();
          Get.back();
          buildCustomSnakbar(
              context: context, icon: Iconsax.trash, message: 'Report dismiss');
        },
      ),
    );
  }
}
