import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';

class ControllerHelpAndFeedback extends GetxController {
  final firestore = FirebaseFirestore.instance;
  Future<void> sendHelpAndFeedbackData({
    required String senderProfileImageUrl,
    required String senderName,
    required String senderMessage,
  }) async {
    firestore.collection('help-and-feedback').doc().set(
      {
        'send-at': Timestamp.now(),
        'sender-profile-image-url': senderProfileImageUrl,
        'sender-name': senderName,
        'sender-message': senderMessage,
      },
    );
  }
}
