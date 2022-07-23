import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:get/get.dart';
import 'package:weconnect/controller/controller_account_information.dart';

//*THIS IS THE INSTANCE TO FIREBASE STORAGE
final firebase_storage.FirebaseStorage storage =
    firebase_storage.FirebaseStorage.instance;

//*LIST OF IMAGE URLS
List<String> listOfImageUrls = [];

//*LIST OF IMAGE PATH
List<File> _pikedImages = [];

int count = 0;

//*DATETIME CREATED FILE NAME
final String _dateTimeNow = DateTime.now().toString();

class ControllerCreatePost extends GetxController {
  Future<void> uploadPostForCampusFeed(
    String collectionName,
    String postCaption,
    String accountName,
    String accountProfileImageUrl,
  ) async {
    FirebaseFirestore.instance
        .collection(collectionName)
        .doc('campus-feed')
        .collection('post')
        .doc()
        .set({
          'account-type': currentAccountType,
          'post-caption': postCaption,
          'post-media': listOfImageUrls,
          'account-name': accountName,
          'account-profile-image-url': accountProfileImageUrl,
          'post-created-at': DateTime.now(),
          'storage-fileName': _dateTimeNow,
          'votes': [],
        })
        .whenComplete(() => {
              Get.back(),
            })
        .catchError(
          (error) => {
            // _customDialog.dialog(
            //     "SOMETHING WENT WRONG", "Failed to add post: $error")
          },
        );
  }

  Future<void> uploadPost(
    String collectionName,
    String postCaption,
    String accountName,
    String accountProfileImageUrl,
    String docName,
  ) async {
    FirebaseFirestore.instance
        .collection(collectionName)
        .doc(docName)
        .collection('post')
        .doc()
        .set({
          'post-caption': postCaption,
          'post-media': listOfImageUrls,
          'account-name': accountName,
          'account-profile-image-url': accountProfileImageUrl,
          'post-created-at': DateTime.now(),
          'storage-fileName': _dateTimeNow,
          'votes': [],
        })
        .whenComplete(() => {
              Get.back(),
            })
        .catchError(
          (error) => {
            // _customDialog.dialog(
            //     "SOMETHING WENT WRONG", "Failed to add post: $error")
          },
        );
  }

  Future<void> dataChecker(
    FilePickerResult? result,
    String collectionName,
    String postCaption,
    String accountName,
    String profileUrl,
    String accountType,
    String docName,
  ) async {
    if (result != null && postCaption.isEmpty == false) {
      _pikedImages = result.paths.map((path) => File(path!)).toList();

      for (var image in _pikedImages) {
        await uploadImagesToFirebaseStorage(
          'file-number-$count',
          image.path,
          accountType,
          _dateTimeNow,
        );
        count++;
      }
      //* ROLE CHECKING FOR UPLOADING POST IN CAMPUS FEED WITH TWO DIFF
      //* ACCOUNT CAMPUS ADMIN AND REGISTRAR
      accountType == 'accountTypeCampusAdmin' ||
              accountType == 'accountTypeRegistrarAdmin'
          ? uploadPostForCampusFeed(
              collectionName,
              postCaption,
              accountName,
              profileUrl,
            )
          : uploadPost(
              collectionName,
              postCaption,
              accountName,
              profileUrl,
              docName,
            );
      listOfImageUrls.clear();
    }

    // if (_postCaption.isEmpty == true) {
    //   _customDialog.dialog(
    //     'DESCRIPTION MISSING',
    //     'Please enter a description for this post to continue',
    //   );
    // } else if (result == null) {
    //   _customDialog.dialog(
    //     'NO MEDIA FILE',
    //     'Please select image to continue',
    //   );
    // }
  }

  Future<void> uploadImagesToFirebaseStorage(
    String fileName,
    String filePath,
    String role,
    String dateTime,
  ) async {
    File file = File(filePath);
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('$role/$dateTime/$fileName')
          .putFile(file)
          .then((value) async {
        String getUrl = await value.ref.getDownloadURL();
        listOfImageUrls.add(getUrl);
      });
    } on firebase_core.FirebaseException catch (e) {
      log(e.toString());
      // e.g, e.code == 'canceled'
    }
  }
}
