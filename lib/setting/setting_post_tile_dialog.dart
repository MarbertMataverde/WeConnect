import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:weconnect/controller/controller_delete_post.dart';

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
          await _controllerDeletePost.deletePost(
              announcementTypeDoc, postDocId, postMedia);
          Get.back();
        },
      ),
    );
  }
}
