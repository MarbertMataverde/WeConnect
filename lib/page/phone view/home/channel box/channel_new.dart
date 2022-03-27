import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/widgets/appbar/build_appbar.dart';
import 'package:weconnect/widgets/global%20spinkit/global_spinkit.dart';
import '../../../../controller/controller_account_information.dart';
import '../../../../controller/controller_channel.dart';
import '../../../../constant/constant.dart';
import '../../../../widgets/text form field/custom_textformfield.dart';

import '../../../../constant/constant_colors.dart';

//random character generator
const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();
String getRandomString(int length) => String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(
          _rnd.nextInt(_chars.length),
        ),
      ),
    );

// Validation Key
final _validationKey = GlobalKey<FormState>();

final channel = Get.put(ControllerChannel());

class ChannelNew extends StatefulWidget {
  const ChannelNew({Key? key}) : super(key: key);

  @override
  State<ChannelNew> createState() => _ChannelNewState();
}

class _ChannelNewState extends State<ChannelNew> {
  File? selectedImage;
  //is create button enable or not
  bool checkIconButtonIsEnable = false;
  //controllers
  final TextEditingController channelNameCtrlr = TextEditingController();
  final TextEditingController channelJoinTokenCtrlr = TextEditingController();

  //is creating?
  bool isCreating = false;

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
      debugPrint('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: 'New Channel',
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
          isCreating
              ? Padding(
                  padding: EdgeInsets.only(right: 2.5.w),
                  child: buildGlobalSpinkit(context: context),
                )
              : IconButton(
                  onPressed: checkIconButtonIsEnable && selectedImage != null
                      ? () async {
                          setState(() {
                            isCreating = true;
                          });
                          await channel.createNewChannelAndUploadAvatarFunction(
                            filePath: selectedImage!.path,
                            channelName: channelNameCtrlr.text,
                            channelAdminName: currentProfileName,
                            professorUid: currentUserId,
                            token: channelJoinTokenCtrlr.text,
                          );
                          setState(() {
                            isCreating = false;
                          });
                        }
                      : null,
                  icon: Icon(
                    Iconsax.tick_square,
                    color: checkIconButtonIsEnable && selectedImage != null
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).disabledColor,
                  ),
                ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 5.h),
        child: Column(
          children: [
            selectedImage != null
                ? GestureDetector(
                    onTap: () {
                      pickImage();
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.w),
                      child: Image.file(
                        selectedImage!,
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.width * 0.25,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Material(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5.w),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(5.w),
                      onTap: () {
                        pickImage();
                      },
                      child: SizedBox(
                        width: Get.mediaQuery.size.width * 0.25,
                        height: Get.mediaQuery.size.width * 0.25,
                        child: Icon(
                          Iconsax.gallery_add,
                          size: 10.w,
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
              child: Column(
                children: [
                  CustomTextFormField(
                      ctrlr: channelNameCtrlr,
                      hint: 'Channel Name',
                      isPassword: kFalse,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Channel name is required😊';
                        }
                        if (value.toString().length < 8) {
                          return 'Channel name should be at least 8 character😊';
                        }
                      }),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: Get.mediaQuery.size.width * 0.6,
                        child: CustomTextFormField(
                          ctrlr: channelJoinTokenCtrlr,
                          hint: 'Token Code',
                          isPassword: kFalse,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Channel token code is required😊';
                            }
                            if (value.toString().length < 7) {
                              return 'Token must be at least 7 character😊';
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          tooltip: 'Generate New Token🔥',
                          onPressed: () {
                            channelJoinTokenCtrlr.text = getRandomString(7);
                          },
                          icon: const Icon(Iconsax.text_block),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          tooltip: 'Copy Token🔥',
                          onPressed: channelJoinTokenCtrlr.text != '' &&
                                  channelJoinTokenCtrlr.text.length == 7
                              ? () {
                                  Clipboard.setData(ClipboardData(
                                          text: channelJoinTokenCtrlr.text))
                                      .then(
                                    (value) => Get.showSnackbar(
                                      GetSnackBar(
                                        icon: Icon(
                                          MdiIcons.checkBold,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        margin: EdgeInsets.all(2.w),
                                        borderRadius: 1.w,
                                        backgroundColor: kButtonColorLightTheme,
                                        message: 'Token copied to clipboard',
                                        duration: const Duration(seconds: 3),
                                        forwardAnimationCurve:
                                            Curves.fastLinearToSlowEaseIn,
                                      ),
                                    ),
                                  );
                                }
                              : null,
                          icon: const Icon(Iconsax.copy),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
