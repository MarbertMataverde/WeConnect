import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

//add vote
Future<void> addVote({
  required String collection,
  required String docName,
  required String subCollection,
  required String topicDocId,
  required List currentUid,
}) async {
  firestore
      .collection(collection)
      .doc(docName)
      .collection(subCollection)
      // .collection('forum')
      // .doc('approved-request')
      // .collection('all-approved-request')
      .doc(topicDocId)
      .update({
    'votes': FieldValue.arrayUnion(currentUid),
  });
}

//remove vote
Future<void> removeVote({
  required String collection,
  required String docName,
  required String subCollection,
  required String topicDocId,
  required List currentUid,
}) async {
  firestore
      .collection(collection)
      .doc(docName)
      .collection(subCollection)
      .doc(topicDocId)
      .update({
    'votes': FieldValue.arrayRemove(currentUid),
  });
}
