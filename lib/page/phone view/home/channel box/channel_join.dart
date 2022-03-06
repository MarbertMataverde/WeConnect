import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../../../controller/controller_account_information.dart';
import '../../../../controller/controller_channel.dart';
import '../../../../constant/constant.dart';
import '../../../../widgets/text form field/custom_textformfield.dart';

import '../../../../constant/constant_colors.dart';
import '../../../../widgets/appbar title/appbar_title.dart';

// Validation Key
final _validationKey = GlobalKey<FormState>();

final channel = Get.put(ControllerChannel());

class ChannelJoin extends StatefulWidget {
  const ChannelJoin({Key? key}) : super(key: key);

  @override
  State<ChannelJoin> createState() => _ChannelJoinState();
}

class _ChannelJoinState extends State<ChannelJoin> {
  File? selectedImage;
  //is create button enable or not
  bool checkIconButtonIsEnable = false;
  //controller
  final TextEditingController tokenCtrlr = TextEditingController();
  //is creating?
  bool isJoining = false;

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
          title: 'Join Channel',
        ),
        actions: [
          isJoining
              ? Padding(
                  padding: EdgeInsets.only(right: 2.5.w),
                  child: SpinKitSpinningLines(
                    color: Get.theme.primaryColor,
                    size: Get.mediaQuery.size.width * 0.08,
                  ),
                )
              : IconButton(
                  onPressed: checkIconButtonIsEnable
                      ? () async {
                          setState(() {
                            isJoining = true;
                          });
                          await channel.channelChecker(
                              token: tokenCtrlr.text,
                              studentUid: [currentUserId]);
                          setState(() {
                            isJoining = false;
                          });
                        }
                      : null,
                  icon: Icon(
                    MdiIcons.check,
                    color: checkIconButtonIsEnable
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
        child: Form(
          key: _validationKey,
          onChanged: () => setState(() => checkIconButtonIsEnable =
              _validationKey.currentState!.validate()),
          child: CustomTextFormField(
            inputAction: TextInputAction.done,
            maxLine: 1,
            ctrlr: tokenCtrlr,
            hint: 'Channel Token',
            isPassword: kFalse,
            validator: (value) {
              if (value.isEmpty) {
                return 'Channel token is required😊';
              }
              if (value.toString().length < 7) {
                return 'Token must be at least 7 character😊';
              }
            },
          ),
        ),
      ),
    );
  }
}
