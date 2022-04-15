import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weconnect/widgets/snakbar/snakbar.dart';

import '../controller/controller_channel.dart';

final channel = Get.put(ControllerChannel());

class DialogChannel extends GetxController {
  //channel delition dialog
  Future<dynamic> deleteChannelDialog(context,
      {required String assetLocation,
      required String title,
      required String description,
      //deletion params
      required String channelDocId,
      required String channelAvatarImage}) async {
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
          await channel.deleteChannel(
            channelDocId,
            channelAvatarImage,
          );
          buildCustomSnakbar(
              context: context,
              icon: Iconsax.box_remove,
              message: 'Channel removed');
        },
      ),
    );
  }

  //change channel name dialog
  Future<dynamic> changeChannelName(
    context,
    String assetLocation,
    String title,
    String description,
    //edit channel name params
    {
    required String token,
    required String newChannelName,
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
          Get.back();
          channel.changeChannelName(
              context: context, token: token, newChannelName: newChannelName);
        },
      ),
    );
  }
}
