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
    String _channelAdminName,
    String _channelName,
    String _professorUid,
  ) async {
    firestore
        .collection('channels')
        .doc()
        .set({
          'channel-admin-name': _channelAdminName,
          'channel-avatar-image': avatarDownloadUrl,
          'channel-name': _channelName,
          'create-at': Timestamp.now(),
          'professor-uid': _professorUid,
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
    String _filePath,
    String _channelName,
  ) async {
    File file = File(_filePath);
    //! if you want to add handling option do it after defense when someone will
    //! help you hehe -marbert :>>
    try {
      await storage
          .ref('channelAvatar/$_channelName')
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
  Future<void> createNewChannelAndUploadAvatarFunction(
    //channel avatar upload
    _filePath,
    _channelName, //? used by both function
    //new chhanel
    _channelAdminName,
    _professorUid,
  ) async {
    await uploadAvatar(
      _filePath,
      _channelName,
    );

    createNewChannel(
      _channelAdminName,
      _channelName,
      _professorUid,
    );
  }
}
