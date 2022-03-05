import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

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
        .doc()
        .set({
          'channel-token': token,
          'channel-admin-name': channelAdminName,
          'channel-avatar-image': avatarDownloadUrl,
          'channel-name': channelName,
          'create-at': Timestamp.now(),
          'professor-uid': professorUid,
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
}
