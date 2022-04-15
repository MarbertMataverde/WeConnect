import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/dialog/dialog_channel.dart';
import 'package:weconnect/widgets/appbar/build_appbar.dart';
import 'package:weconnect/widgets/text%20form%20field/custom_textformfield.dart';

final _dialog = Get.put(DialogChannel());

class EditChannelName extends StatelessWidget {
  const EditChannelName(
      {Key? key, required this.currentName, required this.token})
      : super(key: key);

  final String currentName;
  final String token;
  @override
  Widget build(BuildContext context) {
    String updateName = '';
    return Scaffold(
      appBar: buildAppBar(
          context: context,
          title: 'Edit Name',
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Iconsax.arrow_square_left,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                Get.focusScope!.unfocus();
                await _dialog.changeChannelName(
                  context,
                  'assets/gifs/pencil_draw_erase.gif',
                  'Update Channel Name',
                  'Are you sure about changing the channel name?',
                  //params
                  token: token,
                  newChannelName: updateName == '' ? currentName : updateName,
                );
              },
              icon: Icon(
                Iconsax.tick_square,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ]),
      body: Padding(
        padding: EdgeInsets.all(2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField(
              initialValue: currentName,
              minimumLine: 1,
              maxLine: 1,
              isPassword: false,
              onChanged: (value) {
                updateName = value.toString();
              },
              validator: (_) {},
            ),
          ],
        ),
      ),
    );
  }
}
