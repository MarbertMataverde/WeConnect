import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import '../controller/controller_forum.dart';

import '../constant/constant_colors.dart';

final ControllerForum forum = Get.put(ControllerForum());

class DialogForum extends GetxController {
  //request dismissal dialog
  Future<dynamic> dismissRequestDialog(
    _context, {
    required String assetLocation,
    required String title,
    required String description,
    //deletion params
    required String requestDocId,
  }) async {
    showDialog(
      context: _context,
      builder: (_) => AssetGiffDialog(
        buttonOkColor: Theme.of(_context).primaryColor,
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
          await forum.dismissRequest(requestDocId: requestDocId);
          Get.back();
          Get.back();
          Get.showSnackbar(GetSnackBar(
            icon: Icon(
              MdiIcons.checkBold,
              color: Get.theme.primaryColor,
            ),
            margin: EdgeInsets.all(2.w),
            borderRadius: 1.w,
            backgroundColor: kButtonColorLightTheme,
            message: 'Success request has been removed.',
            duration: const Duration(seconds: 2),
            forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
          ));
        },
      ),
    );
  }

  //request approval dialog
  Future<dynamic> requestApprovalDialog(
    _context, {
    required String assetLocation,
    required String title,
    required String description,
    //request database writing params
    required String requestedBy,
    required String requesterProfileImageUrl,
    required String requesterUid,
    required String topicTitle,
    required String topicDescription,
    //removing this old request
    required String requestDocId,
  }) async {
    showDialog(
      context: _context,
      builder: (_) => AssetGiffDialog(
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
        onOkButtonPressed: () async {
          await forum.requestApproval(
            requestedBy: requestedBy,
            requesterProfileImageUrl: requesterProfileImageUrl,
            requesterUid: requesterUid,
            topicTitle: topicTitle,
            topicDescription: topicDescription,
            requestDocId: requestDocId,
          );
          Get.back();
          Get.back();
          Get.showSnackbar(GetSnackBar(
            icon: Icon(
              MdiIcons.checkBold,
              color: Get.theme.primaryColor,
            ),
            margin: EdgeInsets.all(2.w),
            borderRadius: 1.w,
            backgroundColor: kButtonColorLightTheme,
            message: 'Success request has been approved.',
            duration: const Duration(seconds: 2),
            forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
          ));
        },
      ),
    );
  }
}
