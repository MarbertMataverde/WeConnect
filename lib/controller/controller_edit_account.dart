import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:weconnect/page/phone%20view/home/upload%20post/upload_post.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

String? getUrl;

class ControllerEditAccount extends GetxController {
  Future uploadNewProfileImage(
    String filePath,
    String role,
    String dateTime,
  ) async {
    File file = File(filePath);
    try {
      await firebaseStorage
          .ref('$role/$dateTime')
          .putFile(file)
          .then((value) async {
        getUrl = await value.ref.getDownloadURL();
      });
    } on FirebaseStorage catch (e) {
      log(e.toString());
      // e.g, e.code == 'canceled'
    }
  }

  Future changeProfileImage({
    required String doc,
    required String currentUid,
  }) async {
    firestore
        .collection('accounts')
        .doc(doc)
        .collection('account')
        .doc(currentUid)
        .set({
      'profile-image-url': getUrl,
    });
  }
}
