import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/widgets/appbar/build_appbar.dart';
import 'package:weconnect/widgets/global%20spinkit/global_spinkit.dart';
import '../../../../controller/controller_account_information.dart';
import '../../../../controller/controller_channel.dart';
import '../../../../constant/constant.dart';
import '../../../../widgets/text form field/custom_textformfield.dart';

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
      appBar: buildAppBar(
        context: context,
        title: 'Join Channel',
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Iconsax.arrow_square_left,
              color: Theme.of(context).iconTheme.color,
            )),
        actions: [
          isJoining
              ? Padding(
                  padding: EdgeInsets.only(right: 2.5.w),
                  child: buildGlobalSpinkit(context: context),
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
                    Iconsax.tick_square,
                    color: checkIconButtonIsEnable
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).disabledColor,
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
