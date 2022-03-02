import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/widgets/widget%20sign%20in/widget_textformfield_login.dart';

import '../../../../../constant/constant_colors.dart';
import '../../../../../widgets/appbar title/appbar_title.dart';

final box = GetStorage();

class EditAccount extends StatefulWidget {
  const EditAccount({Key? key}) : super(key: key);

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
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
          title: 'Edit Account',
        ),
      ),
      body: Column(
        children: [
          selectedImage != null
              ? buildNewProfileImage(
                  onCliked: () => pickImage(),
                  newProfileImage: selectedImage,
                )
              : buildPreviousProfileImage(
                  onCliked: () => pickImage(),
                ),
          // CustomTextFormField(ctrlr: ctrlr, hint: box.read('current'), isPassword: isPassword, validator: validator)
        ],
      ),
    );
  }
}

Widget buildPreviousProfileImage({
  VoidCallback? onCliked,
}) {
  return Container(
    width: Get.mediaQuery.size.width,
    height: Get.mediaQuery.size.height * 0.35,
    color: Get.theme.primaryColor.withOpacity(0.4),
    child: Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: Get.mediaQuery.size.width * 0.15,
          backgroundImage: NetworkImage(
            box.read('profileImageUrl'),
          ),
        ),
        Positioned(
          right: Get.mediaQuery.size.width * 0.33,
          top: Get.mediaQuery.size.width * 0.37,
          child: GestureDetector(
            onTap: onCliked,
            child: Container(
              padding: EdgeInsets.all(1.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Get.isDarkMode
                    ? kTextFormFieldColorDarkTheme
                    : kTextFormFieldColorLightTheme,
              ),
              child: Icon(
                MdiIcons.cameraOutline,
                color: Get.isDarkMode
                    ? kButtonColorDarkTheme
                    : kButtonColorLightTheme,
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget buildNewProfileImage({
  VoidCallback? onCliked,
  File? newProfileImage,
}) {
  return Container(
    width: Get.mediaQuery.size.width,
    height: Get.mediaQuery.size.height * 0.35,
    color: Get.theme.primaryColor.withOpacity(0.4),
    child: Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: Get.mediaQuery.size.width * 0.15,
          backgroundImage: FileImage(
            newProfileImage!,
          ),
        ),
        Positioned(
          right: Get.mediaQuery.size.width * 0.33,
          top: Get.mediaQuery.size.width * 0.37,
          child: GestureDetector(
            onTap: onCliked,
            child: Container(
              padding: EdgeInsets.all(1.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Get.isDarkMode
                    ? kTextFormFieldColorDarkTheme
                    : kTextFormFieldColorLightTheme,
              ),
              child: Icon(
                MdiIcons.cameraOutline,
                color: Get.isDarkMode
                    ? kButtonColorDarkTheme
                    : kButtonColorLightTheme,
              ),
            ),
          ),
        )
      ],
    ),
  );
}
