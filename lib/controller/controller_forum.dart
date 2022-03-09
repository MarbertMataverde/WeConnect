import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';

import '../constant/constant_colors.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class ControllerForum extends GetxController {
  Future<void> forumTopicRequest({
    required String requestedBy,
    required String requesterProfileImageUrl,
    required String requesterUid,
    required String topicTitle,
    required String topicDescription,
  }) async {
    firestore.collection('forum-topic-request').doc().set({
      'topic-title': topicTitle,
      'topic-description': topicDescription,
      'requester-uid': requesterUid,
      'requested-at': Timestamp.now(),
      // 'request-accepted-at': Timestamp.now(),
      'requested-by': requestedBy,
      'requester-profile-image-url': requesterProfileImageUrl,
      'votes': 0,
    }).whenComplete(() {
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
          message: 'Success request has been sent.',
          duration: const Duration(seconds: 2),
          forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
        ),
      );
    });
  }

  Future<void> dismissRequest({required requestDocId}) async {
    firestore.collection('forum-topic-request').doc(requestDocId).delete();
  }
}
