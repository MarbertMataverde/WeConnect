import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import '../controller/controller_forum.dart';

import '../constant/constant_colors.dart';
import '../widgets/text form field/custom_textformfield.dart';

final ControllerForum forum = Get.put(ControllerForum());

class DialogForum extends GetxController {
  //request dismissal dialog
  Future<dynamic> dismissRequestDialog(
    context, {
    required String assetLocation,
    required String title,
    required String description,
    //deletion params
    required String requestDocId,
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
          await forum.dismissRequest(requestDocId: requestDocId);
          Get.back();
          Get.back();
          Get.showSnackbar(
            GetSnackBar(
              icon: Icon(
                MdiIcons.checkBold,
                color: Theme.of(context).primaryColor,
              ),
              margin: EdgeInsets.all(2.w),
              borderRadius: 1.w,
              backgroundColor: kButtonColorLightTheme,
              message: 'Request has been removed',
              duration: const Duration(seconds: 1),
              forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
            ),
          );
        },
      ),
    );
  }

  //request approval dialog
  Future<dynamic> requestApprovalDialog(
    context, {
    required String assetLocation,
    required String title,
    required String description,
    //request database writing params
    required String requestedBy,
    required String requesterProfileImageUrl,
    required String requesterUid,
    required String topicTitle,
    required String topicDescription,
    //removing this old request
    required String requestDocId,
  }) async {
    showDialog(
      context: context,
      builder: (_) => AssetGiffDialog(
        buttonOkColor: Theme.of(context).primaryColor,
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
          await forum.requestApproval(
            requestedBy: requestedBy,
            requesterProfileImageUrl: requesterProfileImageUrl,
            requesterUid: requesterUid,
            topicTitle: topicTitle,
            topicDescription: topicDescription,
            requestDocId: requestDocId,
          );
          Get.back();
          Get.back();
          Get.showSnackbar(GetSnackBar(
            icon: Icon(
              MdiIcons.checkBold,
              color: Theme.of(context).primaryColor,
            ),
            margin: EdgeInsets.all(2.w),
            borderRadius: 1.w,
            backgroundColor: kButtonColorLightTheme,
            message: 'Request has been approved.',
            duration: const Duration(seconds: 1),
            forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
          ));
        },
      ),
    );
  }

  //report topic dialog
  Future<dynamic> reportTopicDialog({
    required BuildContext context,
    required String reportDocumentId,
  }) async {
    // Validation Key
    final _validationKey = GlobalKey<FormState>();
    //controllers
    final TextEditingController reportConcernCtrlr = TextEditingController();
    final TextEditingController reportConcernDescriptionCtrlr =
        TextEditingController();
    Get.defaultDialog(
      barrierDismissible: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      radius: 1.w,
      title: 'Report post 🧐',
      content: Form(
        key: _validationKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextFormField(
                ctrlr: reportConcernCtrlr,
                hint: 'Reason of report..',
                isPassword: false,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter the reason of report😊';
                  }

                  return null;
                },
              ),
              SizedBox(height: 1.h),
              CustomTextFormField(
                minimumLine: 3,
                maxLine: 5,
                ctrlr: reportConcernDescriptionCtrlr,
                hint: 'Your concern description..',
                isPassword: false,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please describe your concern🤗';
                  }

                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            primary: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
            ),
          ),
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'Cancel',
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.7),
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1)),
          onPressed: () async {
            final _isValid = _validationKey.currentState!.validate();
            Get.focusScope!.unfocus();

            if (_isValid == true) {
              await forum.forumTopicReport(
                reportConcern: reportConcernCtrlr.text,
                reportConcernDescription: reportConcernDescriptionCtrlr.text,
                reportDocummentId: reportDocumentId,
              );
              Get.back();
              Get.showSnackbar(GetSnackBar(
                icon: Icon(
                  MdiIcons.checkBold,
                  color: Theme.of(context).primaryColor,
                ),
                margin: EdgeInsets.all(2.w),
                borderRadius: 1.w,
                backgroundColor: kButtonColorLightTheme,
                message: 'Report submitted',
                duration: const Duration(seconds: 1),
                forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
              ));
            }
          },
          child: const Text('Submit'),
        )
      ],
    );
  }

  //topic delition dialog
  Future<dynamic> deleteTopicDialog(
    context, {
    required String assetLocation,
    required String title,
    required String description,
    required String topicDocId,
  }) async {
    showDialog(
      context: context,
      builder: (_) => AssetGiffDialog(
        buttonOkColor: Theme.of(context).primaryColor,
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
          await forum.topicDeletion(topicDocId: topicDocId);
          Get.back();
          Get.showSnackbar(GetSnackBar(
            icon: Icon(
              MdiIcons.checkBold,
              color: Theme.of(context).primaryColor,
            ),
            margin: EdgeInsets.all(2.w),
            borderRadius: 1.w,
            backgroundColor: kButtonColorLightTheme,
            message: 'Topic removed',
            duration: const Duration(seconds: 1),
            forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
          ));
        },
      ),
    );
  }
}
