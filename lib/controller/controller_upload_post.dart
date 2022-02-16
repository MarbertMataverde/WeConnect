import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:shared_preferences/shared_preferences.dart';

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

class UploadPost extends GetxController {
  Future<void> uploadPostForCampusFeed(
    String _collectionName,
    String _postDescription,
    String _profileName,
    String _profileUrl,
  ) async {
    FirebaseFirestore.instance
        .collection(_collectionName)
        .doc('campus-feed-post')
        .collection('post')
        .doc()
        .set({
          'post-description': _postDescription,
          'post-media': listOfImageUrls,
          'profile-name': _profileName,
          'profile-url': _profileUrl,
          'created-at': DateTime.now(),
          'storage-fileName': _dateTimeNow
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
    String _collectionName,
    String _postDescription,
    String _profileName,
    String _profileUrl,
    String _docName,
  ) async {
    FirebaseFirestore.instance
        .collection(_collectionName)
        .doc(_docName)
        .collection('post')
        .doc()
        .set({
          'post-description': _postDescription,
          'post-media': listOfImageUrls,
          'profile-name': _profileName,
          'profile-url': _profileUrl,
          'created-at': DateTime.now(),
          'storage-fileName': _dateTimeNow
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
    String _collectionName,
    String _postDescription,
    String _profileName,
    String _profileUrl,
    String _role,
    String _docName,
  ) async {
    if (result != null && _postDescription.isEmpty == false) {
      _pikedImages = result.paths.map((path) => File(path!)).toList();

      for (var image in _pikedImages) {
        await uploadImagesToFirebaseStorage(
          'file-number-$count',
          image.path,
          _role,
          _dateTimeNow,
        );
        count++;
      }
      //* ROLE CHECKING FOR UPLOADING POST IN CAMPUS FEED WITH TWO DIFF
      //* ACCOUNT CAMPUS ADMIN AND REGISTRAR
      _role == 'CAMPUS-ADMIN' || _role == 'REGISTRAR-ADMIN'
          ? uploadPostForCampusFeed(
              _collectionName,
              _postDescription,
              _profileName,
              _profileUrl,
            )
          : uploadPost(
              _collectionName,
              _postDescription,
              _profileName,
              _profileUrl,
              _docName,
            );
      listOfImageUrls.clear();
    }

    // if (_postDescription.isEmpty == true) {
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
