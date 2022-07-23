import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ControllerWritePostComment extends GetxController {
  Future<void> writeCommentToCampusPost(
    String collectionName,
    String docName,
    String userComment,
    String userProfileUrl,
    String userName,
    String postDocId,
    Timestamp dateTime,
  ) async {
    FirebaseFirestore.instance
        .collection(collectionName)
        .doc(docName)
        .collection('post')
        .doc(postDocId)
        .collection('comments')
        .doc()
        .set({
      'comment': userComment,
      'profile-name': userName,
      'profile-url': userProfileUrl,
      'created-at': dateTime
    });
  }
}
