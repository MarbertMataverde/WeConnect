import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/controller/controller_delete_post.dart';

import '../constant/constant_colors.dart';

final _controllerDeletePost = Get.put(ControllerDeletePost());

class SettingPostTileDialog extends GetxController {
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
          _controllerDeletePost.deletePost(
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
}
