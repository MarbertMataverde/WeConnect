import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ControllerDeletePost extends GetxController {
  //*DELETING POST
  late List<String> url;
  Future<void> deletePost(
    //*Firestore
    String announcementTypeDoc,
    String postDocId,
    List<dynamic> imageUrls,
  ) async {
    await FirebaseFirestore.instance
        .collection('announcements')
        .doc(announcementTypeDoc)
        .collection('post')
        .doc(postDocId)
        .delete();
    for (var i = 0; i < imageUrls.length; i++) {
      String url = imageUrls[i];
      deleteImageFromFireStoreStorage(url);
    }
  }

  Future<void> deleteImageFromFireStoreStorage(String imageUrl) async {
    firebase_storage.FirebaseStorage.instance.refFromURL(imageUrl).delete();
  }
}