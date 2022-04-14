import 'package:cloud_firestore/cloud_firestore.dart' as firebase;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';

import '../constant/constant_colors.dart';

class ControllerEditPostCaption extends GetxController {
  Future editPostCaption(String docName, String postDocId, String updatedData,
      {required BuildContext context}) async {
    firebase.FirebaseFirestore.instance
        .collection('announcements')
        .doc(docName)
        .collection('post')
        .doc(postDocId)
        .update({'post-caption': updatedData}).whenComplete(
      () => {
        Get.back(),
        Get.back(),
        Get.showSnackbar(
          GetSnackBar(
            icon: Icon(
              MdiIcons.checkBold,
              color: Theme.of(context).primaryColor,
            ),
            margin: EdgeInsets.all(2.w),
            borderRadius: 1.w,
            backgroundColor: kButtonColorLightTheme,
            message: 'Success post caption has been updated',
            duration: const Duration(seconds: 3),
            forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
          ),
        ),
      },
    );
  }
}
