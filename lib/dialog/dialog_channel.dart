import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';

import '../constant/constant_colors.dart';
import '../controller/controller_channel.dart';

final channel = Get.put(ControllerChannel());

class DialogChannel extends GetxController {
  //channel delition dialog
  Future<dynamic> deleteChannelDialog(_context,
      {required String assetLocation,
      required String title,
      required String description,
      //deletion params
      required String channelDocId,
      required String channelAvatarImage}) async {
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
          await channel.deleteChannel(
            channelDocId,
            channelAvatarImage,
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
            message: 'Success channel has been removed',
            duration: const Duration(seconds: 3),
            forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
          ));
        },
      ),
    );
  }
}
