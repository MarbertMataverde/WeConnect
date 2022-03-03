import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../../../constant/constant_colors.dart';

final box = GetStorage();

final TextEditingController channelNameCtrlr = TextEditingController();

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
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Get.isDarkMode ? kTextColorDarkTheme : kTextColorLightTheme,
          ),
        ),
        centerTitle: true,
        title: Text(
          'Create New Channel',
          style: TextStyle(
            fontSize: 15.sp,
            color: Get.theme.primaryColor,
          ),
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
              Icons.check,
              color:
                  Get.isDarkMode ? kTextColorDarkTheme : kTextColorLightTheme,
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
                          width: 20.w,
                          height: 20.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )

                // ? Image.file(
                //     selectedImage!,
                //   )
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
                          width: 20.w,
                          height: 20.w,
                          child: Icon(
                            Icons.image,
                            size: 10.w,
                          ),
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: 3.h,
            ),
            TextFormField(
              controller: channelNameCtrlr,
              cursorColor: Get.theme.primaryColor,
              style: TextStyle(
                color:
                    Get.isDarkMode ? kTextColorDarkTheme : kTextColorLightTheme,
                fontWeight: FontWeight.w700,
                fontSize: 10.sp,
              ),
              decoration: InputDecoration(
                labelText: 'Channel Name',
                labelStyle: TextStyle(
                  color: Get.isDarkMode
                      ? kTextColorDarkTheme
                      : kTextColorLightTheme,
                  fontWeight: FontWeight.w700,
                  fontSize: 10.sp,
                ),
                //*Filled Color
                filled: true,
                fillColor: Get.isDarkMode
                    ? kTextFormFieldColorDarkTheme
                    : kTextFormFieldColorLightTheme,
                //*Enabled Border
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(2.sp),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Get.theme.primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
