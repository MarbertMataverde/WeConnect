import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:iconsax/iconsax.dart';

import 'package:sizer/sizer.dart';
import '../constant/constant.dart';
import '../controller/controller_delete_post.dart';
import '../controller/controller_report.dart';

import '../controller/controller_edit_post_caption.dart';
import '../widgets/snakbar/snakbar.dart';
import '../widgets/text form field/custom_textformfield.dart';

//delete post
final controllerDeletePost = Get.put(ControllerDeletePost());

//edit caption controller
final controllerEditCaption = Get.put(ControllerEditPostCaption());

//report post
final controllerReportPost = Get.put(ControllerReport());

class DialogPostTile extends GetxController {
  //post delition dialog
  Future<dynamic> deletePostDialog(
    context,
    String assetLocation,
    String title,
    String description,
    //deletion params
    String announcementTypeDoc,
    String postDocId,
    List postMedia,
  ) async {
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
          controllerDeletePost.deletePost(
              announcementTypeDoc, postDocId, postMedia);
          Get.back();
          Get.showSnackbar(GetSnackBar(
            icon: Icon(
              Iconsax.check,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            margin: EdgeInsets.all(2.w),
            borderRadius: 1.w,
            backgroundColor: Theme.of(context).primaryColor.withAlpha(200),
            message: 'Post has been removed',
            duration: const Duration(seconds: 1),
            forwardAnimationCurve: Curves.easeInOutCubicEmphasized,
          ));
        },
      ),
    );
  }

  //post edit caption dialog
  Future<dynamic> postEditCaptionDialog(
    context,
    String assetLocation,
    String title,
    String description,
    //edit caption params
    String announcementTypeDoc,
    String postDocId,
    String updatedCaption,
  ) async {
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
          await controllerEditCaption.editPostCaption(
            announcementTypeDoc,
            postDocId,
            updatedCaption,
            context: context,
          );
          Get.back();
        },
      ),
    );
  }

  //report post dialog
  Future<dynamic> reportPostDialog({
    required BuildContext context,
    required String reportType,
    required String reportDocumentId,
  }) async {
    // Validation Key
    final validationKey = GlobalKey<FormState>();
    //controllers
    final TextEditingController reportConcernCtrlr = TextEditingController();
    final TextEditingController reportConcernDescriptionCtrlr =
        TextEditingController();
    Get.defaultDialog(
      barrierDismissible: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      radius: 1.w,
      title: 'Report Form',
      titleStyle: TextStyle(
        color: Theme.of(context).textTheme.bodyMedium!.color,
      ),
      content: Form(
        key: validationKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextFormField(
                ctrlr: reportConcernCtrlr,
                hint: 'Reason of report..',
                isPassword: kFalse,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter the reason of report';
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
                isPassword: kFalse,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please describe your concern';
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
            final isValid = validationKey.currentState!.validate();
            Get.focusScope!.unfocus();

            if (isValid == true) {
              await controllerReportPost.announcementReport(
                reportType: reportType,
                reportConcern: reportConcernCtrlr.text,
                reportConcernDescription: reportConcernDescriptionCtrlr.text,
                reportDocummentId: reportDocumentId,
              );
              Get.back();
              buildCustomSnakbar(
                  context: context,
                  icon: Iconsax.tick_square,
                  message: 'Report submitted.');
            }
          },
          child: const Text('Submit'),
        )
      ],
    );
  }
}
