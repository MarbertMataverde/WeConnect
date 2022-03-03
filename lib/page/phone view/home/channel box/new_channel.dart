import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../../../constant/constant.dart';
import '../../../../widgets/text form field/custom_textformfield.dart';

import '../../../../constant/constant_colors.dart';
import '../../../../widgets/appbar title/appbar_title.dart';

final box = GetStorage();

final TextEditingController channelNameCtrlr = TextEditingController();

// Validation Key
final _validationKey = GlobalKey<FormState>();

class NewChannel extends StatefulWidget {
  const NewChannel({Key? key}) : super(key: key);

  @override
  State<NewChannel> createState() => _NewChannelState();
}

class _NewChannelState extends State<NewChannel> {
  File? selectedImage;

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
            onPressed: () {
              // _newChannel.createNewChannelAndUploadAvatarFunction(
              //   selectedImage!.path,
              //   channelNameCtrlr.text,
              //   box.read('currentUserProfileName'),
              //   box.read('uid'),
              // );
            },
            icon: Icon(
              MdiIcons.check,
              color: selectedImage != null &&
                      _validationKey.currentState!.validate() == kTrue
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
              child: CustomTextFormField(
                  ctrlr: channelNameCtrlr,
                  hint: 'Channel Name',
                  isPassword: kFalse,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Your Email😊';
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
