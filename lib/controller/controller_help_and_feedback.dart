import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weconnect/widgets/snakbar/snakbar.dart';

class ControllerHelpAndFeedback extends GetxController {
  final firestore = FirebaseFirestore.instance;
  // send new feedback message
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

  //request dismissal dialog
  Future<dynamic> removeFeedback(
    context, {
    required String assetLocation,
    required String title,
    required String description,
    //deletion params
    required String feedbackId,
  }) async {
    showDialog(
      context: context,
      builder: (_) => AssetGiffDialog(
        buttonOkColor: Theme.of(context).primaryColor,
        buttonOkText: const Text(
          'Yes',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        image: Image.asset(
          assetLocation,
          fit: BoxFit.cover,
        ),
        entryAnimation: EntryAnimation.bottom,
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
        ),
        description: Text(
          description,
          textAlign: TextAlign.center,
        ),
        onOkButtonPressed: () async {
          await firestore
              .collection('help-and-feedback')
              .doc(feedbackId)
              .delete();
          Navigator.pop(context);
          buildCustomSnakbar(
              context: context,
              icon: Iconsax.tick_square,
              message: 'Feedback removed');
        },
      ),
    );
  }
}
