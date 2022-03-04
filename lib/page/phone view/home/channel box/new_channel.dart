import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/controller/controller_new_channel.dart';
import '../../../../constant/constant.dart';
import '../../../../widgets/text form field/custom_textformfield.dart';

import '../../../../constant/constant_colors.dart';
import '../../../../widgets/appbar title/appbar_title.dart';

final box = GetStorage();

// Validation Key
final _validationKey = GlobalKey<FormState>();

final channel = Get.put(ControllerNewChannel());

class NewChannel extends StatefulWidget {
  const NewChannel({Key? key}) : super(key: key);

  @override
  State<NewChannel> createState() => _NewChannelState();
}

class _NewChannelState extends State<NewChannel> {
  File? selectedImage;
  //is create button enable or not
  bool checkIconButtonIsEnable = false;
  //controller
  final TextEditingController channelNameCtrlr = TextEditingController();

  Future pickImage() async {
    try {
      final selectedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (selectedImage == null) {
        return;
      }
      final selectedTempImage = File(selectedImage.path);
      setState(() {
        this.selectedImage = selectedTempImage;
      });
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              MdiIcons.arrowLeft,
              color: Get.isDarkMode
                  ? kButtonColorDarkTheme
                  : kButtonColorLightTheme,
            )),
        centerTitle: true,
        title: const AppBarTitle(
          title: 'Create New Channel',
        ),
        actions: [
          IconButton(
            onPressed: checkIconButtonIsEnable && selectedImage != null
                ? () {
                    channel.createNewChannelAndUploadAvatarFunction(
                      filePath: selectedImage!.path,
                      channelName: channelNameCtrlr.text,
                      channelAdminName: box.read('profileName'),
                      professorUid: box.read('currentUid'),
                    );
                  }
                : null,
            icon: Icon(
              MdiIcons.check,
              color: checkIconButtonIsEnable && selectedImage != null
                  ? Get.theme.primaryColor
                  : Get.isDarkMode
                      ? kButtonColorDarkTheme
                      : kButtonColorLightTheme,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 5.h),
        child: Column(
          children: [
            selectedImage != null
                ? ClipOval(
                    child: Material(
                      color: Get.theme.primaryColor, // Button color
                      child: InkWell(
                        splashColor:
                            Get.theme.dialogBackgroundColor, // Splash color
                        onTap: () {
                          pickImage();
                        },
                        child: Image.file(
                          selectedImage!,
                          width: Get.mediaQuery.size.width * 0.25,
                          height: Get.mediaQuery.size.width * 0.25,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                : ClipOval(
                    child: Material(
                      color: Get.theme.primaryColor, // Button color
                      child: InkWell(
                        splashColor:
                            Get.theme.dialogBackgroundColor, // Splash color
                        onTap: () {
                          pickImage();
                        },
                        child: SizedBox(
                          width: Get.mediaQuery.size.width * 0.25,
                          height: Get.mediaQuery.size.width * 0.25,
                          child: Icon(
                            MdiIcons.camera,
                            size: 10.w,
                          ),
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: 3.h,
            ),
            Form(
              key: _validationKey,
              onChanged: () => setState(() => checkIconButtonIsEnable =
                  _validationKey.currentState!.validate()),
              child: CustomTextFormField(
                  ctrlr: channelNameCtrlr,
                  hint: 'Channel Name',
                  isPassword: kFalse,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Channel name is required😊';
                    }
                    if (value.toString().length <= 8) {
                      return 'Channel name should be at least 8 character😊';
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
