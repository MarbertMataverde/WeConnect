import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/constant/constant.dart';
import 'package:weconnect/controller/controller_delete_post.dart';
import 'package:weconnect/controller/controller_report.dart';
import 'package:weconnect/widgets/widget%20sign%20in/widget_textformfield_login.dart';

import '../constant/constant_colors.dart';
import '../controller/controller_edit_post_caption.dart';

//delete post
final controllerDeletePost = Get.put(ControllerDeletePost());

//edit caption controller
final controllerEditCaption = Get.put(ControllerEditPostCaption());

//report post
final controllerReportPost = Get.put(ControllerReport());

class DialogPostTile extends GetxController {
  //post delition dialog
  Future<dynamic> deletePostDialog(
    _context,
    String assetLocation,
    String title,
    String description,
    //deletion params
    String announcementTypeDoc,
    String postDocId,
    List postMedia,
  ) async {
    showDialog(
      context: _context,
      builder: (_) => AssetGiffDialog(
        buttonOkColor: Get.theme.primaryColor,
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
              MdiIcons.checkBold,
              color: Get.theme.primaryColor,
            ),
            margin: EdgeInsets.all(2.w),
            borderRadius: 1.w,
            backgroundColor: kButtonColorLightTheme,
            message: 'Success post has been removed',
            duration: const Duration(seconds: 3),
            forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
          ));
        },
      ),
    );
  }

  //post edit caption dialog
  Future<dynamic> postEditCaptionDialog(
    _context,
    String assetLocation,
    String title,
    String description,
    //edit caption params
    String announcementTypeDoc,
    String postDocId,
    String updatedCaption,
  ) async {
    showDialog(
      context: _context,
      builder: (_) => AssetGiffDialog(
        buttonOkColor: Get.theme.primaryColor,
        buttonOkText: Text(
          'Yes',
          style: TextStyle(
            color: Get.theme.textTheme.button!.color,
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
          await controllerEditCaption.editPostCaption(
            announcementTypeDoc,
            postDocId,
            updatedCaption,
          );
        },
      ),
    );
  }

  //report post dialog
  Future<dynamic> reportPostDialog({
    required String reportType,
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
      backgroundColor: Get.theme.scaffoldBackgroundColor,
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
                isPassword: kFalse,
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
                isPassword: kFalse,
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
            primary: Get.theme.primaryColor,
            padding: EdgeInsets.symmetric(
              horizontal: Get.mediaQuery.size.width * 0.1,
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
              backgroundColor: Get.theme.primaryColor.withOpacity(0.7),
              padding: EdgeInsets.symmetric(
                  horizontal: Get.mediaQuery.size.width * 0.1)),
          onPressed: () async {
            final _isValid = _validationKey.currentState!.validate();
            Get.focusScope!.unfocus();

            if (_isValid == true) {
              await controllerReportPost.newReport(
                reportType: reportType,
                reportConcern: reportConcernCtrlr.text,
                reportConcernDescription: reportConcernDescriptionCtrlr.text,
                reportDocummentId: reportDocumentId,
              );
              Get.back();
              Get.showSnackbar(GetSnackBar(
                icon: Icon(
                  MdiIcons.checkBold,
                  color: Get.theme.primaryColor,
                ),
                margin: EdgeInsets.all(2.w),
                borderRadius: 1.w,
                backgroundColor: kButtonColorLightTheme,
                message: 'Success report submitted.',
                duration: const Duration(seconds: 3),
                forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
              ));
            }
          },
          child: const Text('Submit'),
        )
      ],
    );
  }
}
