import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

final FirebaseStorage storage = FirebaseStorage.instance;
final firestore = FirebaseFirestore.instance;

String avatarDownloadUrl = '';

class ControllerNewChannel extends GetxController {
  Future<void> createNewChannel(
    String channelAdminName,
    String channelName,
    String professorUid,
  ) async {
    firestore
        .collection('channels')
        .doc()
        .set({
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
      String _channelDocId, String _avatarImageUrl) async {
    firestore.collection('channels').doc(_channelDocId).delete().whenComplete(
        () => deleteAvatarImageFromFireStoreStorage(_avatarImageUrl));
  }

  Future<void> deleteAvatarImageFromFireStoreStorage(String imageUrl) async {
    storage.refFromURL(imageUrl).delete();
  }

  //uploading new avatar image for new channel
  Future<void> uploadAvatar(
    String filePath,
    String channelName,
  ) async {
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
  }) async {
    await uploadAvatar(
      filePath,
      channelName,
    );

    createNewChannel(
      channelAdminName,
      channelName,
      professorUid,
    );
  }
}
