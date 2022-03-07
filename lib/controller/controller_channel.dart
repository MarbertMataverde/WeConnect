import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';

import '../constant/constant_colors.dart';

final FirebaseStorage storage = FirebaseStorage.instance;
final firestore = FirebaseFirestore.instance;

String avatarDownloadUrl = '';

class ControllerChannel extends GetxController {
  Future<void> createNewChannel({
    required String channelAdminName,
    required String channelName,
    required String professorUid,
    required String token,
  }) async {
    firestore
        .collection('channels')
        .doc(token)
        .set({
          'channel-admin-name': channelAdminName,
          'channel-avatar-image': avatarDownloadUrl,
          'channel-name': channelName,
          'create-at': Timestamp.now(),
          'professor-uid': professorUid,
          'subscriber-list': [],
        })
        .whenComplete(() => {
              Get.back(),
            })
        .catchError(
          (error) => {
            // _customDialog.dialog(
            //     "SOMETHING WENT WRONG", "Failed to add new channel: $error")
          },
        );
  }

  //deleting channel
  Future<void> deleteChannel(
    String _channelDocId,
    String _avatarImageUrl,
  ) async {
    firestore.collection('channels').doc(_channelDocId).delete().whenComplete(
        () => deleteAvatarImageFromFireStoreStorage(_avatarImageUrl));
  }

  Future<void> deleteAvatarImageFromFireStoreStorage(String imageUrl) async {
    storage.refFromURL(imageUrl).delete();
  }

  //uploading new avatar image for new channel
  Future<void> uploadAvatar({
    required String filePath,
    required String channelName,
  }) async {
    File file = File(filePath);
    //! if you want to add handling option do it after defense when someone will
    //! help you hehe -marbert :>>
    try {
      await storage
          .ref('channelAvatar/$channelName')
          .putFile(file)
          .then((value) async {
        String getDownloadUrlOfTheAvatar = await value.ref.getDownloadURL();
        avatarDownloadUrl = getDownloadUrlOfTheAvatar;
      });
    } on FirebaseException catch (e) {
      log(e.code);
    }
  }

  //new channel execcuter
  Future<void> createNewChannelAndUploadAvatarFunction({
    //channel avatar upload
    filePath,
    channelName, //? used by both function
    //new chhanel
    channelAdminName,
    professorUid,
    token,
  }) async {
    await uploadAvatar(
      filePath: filePath,
      channelName: channelName,
    );

    createNewChannel(
      token: token,
      channelAdminName: channelAdminName,
      channelName: channelName,
      professorUid: professorUid,
    );
  }

  //join channel
  Future<void> joinChannel({
    required String token,
    required List studentUid,
  }) async {
    firestore
        .collection('channels')
        .doc(token)
        .update({'subscriber-list': FieldValue.arrayUnion(studentUid)});
    Get.back();
  }

  //channel is exsisting or not checker
  Future<void> channelChecker(
      {required String token, required List studentUid}) async {
    firestore.collection('channels').doc(token).get().then(
          (channelExsist) => channelExsist.exists
              ? joinChannel(token: token, studentUid: studentUid)
              : Get.showSnackbar(GetSnackBar(
                  icon: Icon(
                    MdiIcons.alphaXBoxOutline,
                    color: Get.theme.primaryColor,
                  ),
                  margin: EdgeInsets.all(2.w),
                  borderRadius: 1.w,
                  backgroundColor: kButtonColorLightTheme,
                  message: 'Token din\'t exsist',
                  duration: const Duration(seconds: 2),
                  forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
                )),
        );
  }

  //create new channel announcement
  Future<void> newChannelAnnouncement({
    String? announcementMessage,
    required String token,
    required String adminName,
  }) async {
    firestore
        .collection('channels')
        .doc(token)
        .collection('channel-announcements')
        .doc()
        .set({
      'announcement-created-at': Timestamp.now(),
      'announcement-message': announcementMessage,
      'admin-name': adminName,
    });
  }
}
