import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ControllerWritePostComment extends GetxController {
  Future<void> writeCommentToCampusPost(
    String _collectionName,
    String _docName,
    String _userComment,
    String _userProfileUrl,
    String _userName,
    String _postDocId,
    Timestamp _dateTime,
  ) async {
    FirebaseFirestore.instance
        .collection(_collectionName)
        .doc(_docName)
        .collection('post')
        .doc(_postDocId)
        .collection('comments')
        .doc()
        .set({
      'comment': _userComment,
      'profile-name': _userName,
      'profile-url': _userProfileUrl,
      'created-at': _dateTime
    });
  }
}
