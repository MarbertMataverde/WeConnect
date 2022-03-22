import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../../../widgets/appbar/appbar_back.dart';

import '../../../../constant/constant_colors.dart';
import '../../../../dialog/dialog_post_tile_.dart';
import '../../../../widgets/appbar/appbar_title.dart';

//dialogs
final dialogs = Get.put(DialogPostTile());

class EditCaption extends StatefulWidget {
  const EditCaption({
    Key? key,
    required this.docName,
    required this.postDocId,
    required this.recentCaption,
  }) : super(key: key);
  final String docName;
  final String postDocId;
  final String recentCaption;

  @override
  State<EditCaption> createState() => _EditCaptionState();
}

class _EditCaptionState extends State<EditCaption> {
  String updatedCaption = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: buildAppbarBackButton(),
        centerTitle: true,
        title: const AppBarTitle(
          title: 'Edit Caption',
        ),
        actions: [
          IconButton(
            onPressed: () async {
              Get.focusScope!.unfocus();
              await dialogs.postEditCaptionDialog(
                context,
                'assets/gifs/pencil_draw_erase.gif',
                'Edit Caption 📝',
                'Are you sure changing this caption? 🤔',
                widget.docName,
                widget.postDocId,
                //this will check if the data of caption has change
                updatedCaption == '' ? widget.recentCaption : updatedCaption,
              );
            },
            icon: Icon(
              MdiIcons.check,
              color: Get.theme.primaryColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Description',
                style: TextStyle(
                  color: Get.theme.primaryColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2.h),
              TextFormField(
                initialValue: widget.recentCaption,
                onChanged: (value) {
                  updatedCaption = value.toString();
                },
                style: TextStyle(
                  color: Get.isDarkMode
                      ? kTextColorDarkTheme
                      : kTextColorLightTheme,
                ),
                cursorColor: Get.theme.primaryColor,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: Get.isDarkMode
                        ? kTextColorDarkTheme
                        : kTextColorLightTheme,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 1.w),
                  hintText: 'Write post description',
                  //*Enabled Border
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Get.isDarkMode
                            ? kTextColorDarkTheme
                            : kTextColorLightTheme),
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
      ),
    );
  }
}
