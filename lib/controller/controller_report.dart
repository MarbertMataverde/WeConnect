import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class ControllerReport extends GetxController {
  Future newReport({
    required reportType,
    required reportConcern,
    required reportConcernDescription,
    required reportDocummentId,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await firestore.collection('reports').doc().set({
      'reported-at': Timestamp.now(),
      'reporter-profile-image-url':
          sharedPreferences.get('currentProfileImageUrl'),
      'reporter-name': sharedPreferences.get('currentProfileName'),
      'reporter-account-type': sharedPreferences.get('accountType'),
      'report-concern': reportConcern,
      'report-concern-description': reportConcernDescription,
      'post-documment-id': reportDocummentId,
      'report-type': reportType,
    });
  }
}
