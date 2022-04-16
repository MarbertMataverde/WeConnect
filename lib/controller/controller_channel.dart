import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:sizer/sizer.dart';
import 'package:weconnect/widgets/snakbar/snakbar.dart';

import '../constant/constant_colors.dart';

final FirebaseStorage storage = FirebaseStorage.instance;
final firestore = FirebaseFirestore.instance;

String avatarDownloadUrl = '';

//images link
List<String> listOfImageUrls = [];
//list of image path
List<File> listOfImagePath = [];

//file link
List<String> listOfFileUrls = [];
//list of file path
List<File> listOfFilePath = [];

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
      {required BuildContext context,
      required String token,
      required List studentUid}) async {
    firestore.collection('channels').doc(token).get().then(
          (channelExsist) => channelExsist.exists
              ? joinChannel(token: token, studentUid: studentUid)
              : Get.showSnackbar(GetSnackBar(
                  icon: Icon(
                    MdiIcons.alphaXBoxOutline,
                    color: Theme.of(context).primaryColor,
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
      'announcement-image-urls': listOfImageUrls,
      'announcement-file-urls': listOfFileUrls,
      'admin-name': adminName,
    });
  }

  //images upload
  Future<void> uploadImagesToFirebaseStorage(
      String filePath, String channelName, String announcementTime) async {
    File file = File(filePath);
    String basename = p.basename(file.path);
    try {
      await storage
          .ref('$channelName/$announcementTime/$basename')
          .putFile(file)
          .then((value) async {
        String getUrl = await value.ref.getDownloadURL();
        listOfImageUrls.add(getUrl);
      });
    } on FirebaseException catch (e) {
      log(e.toString());
      // e.g, e.code == 'canceled'
    }
  }

  //file upload
  Future<void> uploadFileToFirebaseStorage(
      String filePath, String channelName, String announcementTime) async {
    File file = File(filePath);
    String basename = p.basename(file.path);
    try {
      await storage
          .ref('$channelName/$announcementTime/$basename')
          .putFile(file)
          .then((value) async {
        String getUrl = await value.ref.getDownloadURL();
        listOfFileUrls.add(getUrl);
      });
    } on FirebaseException catch (e) {
      log(e.toString());
      // e.g, e.code == 'canceled'
    }
  }

  //uploading everything in the firestore and storage
  Future<void> uploadAnnouncement({
    FilePickerResult? imagePicked,
    FilePickerResult? filePicked,
    String? channelName,
    String? announcementMessage,
    required String token,
    required String adminName,
  }) async {
    final Timestamp announcementTime = Timestamp.now();
    if (announcementMessage!.isNotEmpty) {
      if (imagePicked != null) {
        if (filePicked != null) {
          // all field has data
          listOfImagePath =
              imagePicked.paths.map((path) => File(path!)).toList();
          // loop for each image
          for (var image in listOfImagePath) {
            await uploadImagesToFirebaseStorage(
              image.path,
              channelName.toString(),
              announcementTime.toString(),
            );
          }
          //file upload
          listOfFilePath = filePicked.paths.map((path) => File(path!)).toList();
          // loop for each file
          for (var file in listOfFilePath) {
            await uploadFileToFirebaseStorage(
              file.path,
              channelName.toString(),
              announcementTime.toString(),
            );
          }

          //announcement message
          newChannelAnnouncement(
            token: token,
            adminName: adminName,
            announcementMessage: announcementMessage,
          );
          listOfFileUrls.clear();
          listOfImageUrls.clear();
        } else {
          //announcement message and image only
          listOfImagePath =
              imagePicked.paths.map((path) => File(path!)).toList();
          // loop for each image
          for (var image in listOfImagePath) {
            await uploadImagesToFirebaseStorage(
              image.path,
              channelName.toString(),
              announcementTime.toString(),
            );
          }
          newChannelAnnouncement(
            token: token,
            adminName: adminName,
            announcementMessage: announcementMessage,
          );
          listOfImageUrls.clear();
        }
      } else if (filePicked != null) {
        //announcement message and file only
        listOfFilePath = filePicked.paths.map((path) => File(path!)).toList();
        // loop for each file
        for (var file in listOfFilePath) {
          await uploadFileToFirebaseStorage(
            file.path,
            channelName.toString(),
            announcementTime.toString(),
          );
        }
        newChannelAnnouncement(
          token: token,
          adminName: adminName,
          announcementMessage: announcementMessage,
        );
        listOfFileUrls.clear();
      } else {
        //announcement message only
        newChannelAnnouncement(
          token: token,
          adminName: adminName,
          announcementMessage: announcementMessage,
        );
      }
    } else if (imagePicked != null) {
      if (filePicked != null) {
        // image and file only
        listOfImagePath = imagePicked.paths.map((path) => File(path!)).toList();
        // loop for each image
        for (var image in listOfImagePath) {
          await uploadImagesToFirebaseStorage(
            image.path,
            channelName.toString(),
            announcementTime.toString(),
          );
        }
        //file upload
        listOfFilePath = filePicked.paths.map((path) => File(path!)).toList();
        // loop for each file
        for (var file in listOfFilePath) {
          await uploadFileToFirebaseStorage(
            file.path,
            channelName.toString(),
            announcementTime.toString(),
          );
        }
        newChannelAnnouncement(
          token: token,
          adminName: adminName,
          announcementMessage: announcementMessage,
        );
        listOfFileUrls.clear();
        listOfImageUrls.clear();
      } else {
        //image only
        listOfImagePath = imagePicked.paths.map((path) => File(path!)).toList();
        // loop for each image
        for (var image in listOfImagePath) {
          await uploadImagesToFirebaseStorage(
            image.path,
            channelName.toString(),
            announcementTime.toString(),
          );
        }
        newChannelAnnouncement(
          token: token,
          adminName: adminName,
          announcementMessage: announcementMessage,
        );
        listOfImageUrls.clear();
      }
    } else if (filePicked != null) {
      //file only
      listOfFilePath = filePicked.paths.map((path) => File(path!)).toList();
      // loop for each file
      for (var file in listOfFilePath) {
        await uploadFileToFirebaseStorage(
          file.path,
          channelName.toString(),
          announcementTime.toString(),
        );
      }
      newChannelAnnouncement(
        token: token,
        adminName: adminName,
        announcementMessage: announcementMessage,
      );
      listOfFileUrls.clear();
    }
  }

  //change channel name
  Future<void> changeChannelName(
      {required BuildContext context,
      required String token,
      required String newChannelName}) async {
    firestore
        .collection('channels')
        .doc(token)
        .update({'channel-name': newChannelName}).whenComplete(() {
      Get.back();
      Get.back();
      Get.back();
      buildCustomSnakbar(
          context: context,
          icon: Iconsax.edit,
          message: 'Channel name updated!');
    });
  }

  // //change channel avatar
  // Future<void> changeChannelAvatar({
  //   required BuildContext context,
  //   //recent avatar deletion
  //   required String avatarStorageRefUrl,
  //   //uploading new avatar to storage
  //   required filePath,
  //   required String channelName,
  //   //channel collection
  //   required String channelToken,
  //   required String channelDocId,
  // }) async {
  //   //deletion of recent avatar
  //   await storage.refFromURL(avatarStorageRefUrl).delete();
  //   //uploading for new avatar image
  //   await uploadAvatar(filePath: filePath, channelName: channelName);
  //   //updating avatar url to new one
  //   await firestore.collection('channels').doc(channelToken).update(
  //     {'channel-avatar-image': avatarDownloadUrl},
  //   ).whenComplete(
  //     () => buildCustomSnakbar(
  //         context: context,
  //         icon: Iconsax.tick_square,
  //         message: 'Channel Avatar Change'),
  //   );
  // }
}
