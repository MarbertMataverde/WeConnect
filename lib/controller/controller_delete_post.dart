import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:universal_html/html.dart';

class ControllerDeletePost extends GetxController {
  //*DELETING POST
  late List<String> url;
  Future<void> deletePost(
    //*Firestore
    String announcementTypeDoc,
    String postDocId,
    List<dynamic> imageUrls,
  ) async {
    //reports deletion
    // final reportedDocumments = await FirebaseFirestore.instance
    //     .collection('reports')
    //     .where('post-documment-id', isEqualTo: postDocId)
    //     .get();

    //comment delition
    await FirebaseFirestore.instance
        .collection('announcements')
        .doc(announcementTypeDoc)
        .collection('post')
        .doc(postDocId)
        .collection('comments')
        .doc()
        .delete();

    //post data delition
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
