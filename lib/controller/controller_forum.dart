import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../constant/constant_colors.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class ControllerForum extends GetxController {
  //new request
  Future<void> forumTopicRequest({
    required String requestedBy,
    required String requesterProfileImageUrl,
    required String requesterUid,
    required String topicTitle,
    required String topicDescription,
    required BuildContext context,
  }) async {
    firestore
        .collection('forum')
        .doc('topic-request')
        .collection('all-request')
        .doc()
        .set({
      'topic-title': topicTitle,
      'topic-description': topicDescription,
      'requested-at': Timestamp.now(),
      'requested-by': requestedBy,
      'requester-uid': requesterUid,
      'requester-profile-image-url': requesterProfileImageUrl,
    }).whenComplete(() {
      Get.back();
      Get.showSnackbar(
        GetSnackBar(
          icon: Icon(
            MdiIcons.checkBold,
            color:Theme.of(context).primaryColor,
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

  //request dismissal
  Future<void> dismissRequest({required requestDocId}) async {
    firestore
        .collection('forum')
        .doc('topic-request')
        .collection('all-request')
        .doc(requestDocId)
        .delete();
  }

  //request approval
  Future<void> requestApproval({
    required String requestedBy,
    required String requesterProfileImageUrl,
    required String requesterUid,
    required String topicTitle,
    required String topicDescription,
    //request removal
    required String requestDocId,
  }) async {
    firestore
        .collection('forum')
        .doc('approved-request')
        .collection('all-approved-request')
        .doc()
        .set({
      'topic-title': topicTitle,
      'topic-description': topicDescription,
      'requester-uid': requesterUid,
      'request-accepted-at': Timestamp.now(),
      'requested-by': requestedBy,
      'requester-profile-image-url': requesterProfileImageUrl,
      'votes': [],
    }).whenComplete(
            () async => await dismissRequest(requestDocId: requestDocId));
  }

  Future<void> addTopicComment({
    required String topicDocId,
    required String commenterProfileImageUrl,
    required String commenterProfileName,
    required String commenterComment,
  }) async {
    firestore
        .collection('forum')
        .doc('approved-request')
        .collection('all-approved-request')
        .doc(topicDocId)
        .collection('topic-comments')
        .doc()
        .set({
      'commenter-profile-image-url': commenterProfileImageUrl,
      'commenter-profile-name': commenterProfileName,
      'commenter-comment': commenterComment,
      'commented-date': Timestamp.now(),
    });
  }

  //forum report
  Future forumTopicReport({
    required reportConcern,
    required reportConcernDescription,
    required reportDocummentId,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await firestore.collection('reports').doc('forum-topic-report').set({
      'reported-at': Timestamp.now(),
      'reporter-profile-image-url':
          sharedPreferences.get('currentProfileImageUrl'),
      'reporter-name': sharedPreferences.get('currentProfileName'),
      'reporter-account-type': sharedPreferences.get('accountType'),
      'report-concern': reportConcern,
      'report-concern-description': reportConcernDescription,
      'topic-documment-id': reportDocummentId,
      'report-type': 'forum',
    });
  }

  // topic deletion
  Future<void> topicDeletion({
    required topicDocId,
  }) async {
    //comment delition
    await firestore
        .collection('forum')
        .doc('approved-request')
        .collection('all-approved-request')
        .doc(topicDocId)
        .delete();
  }
}
