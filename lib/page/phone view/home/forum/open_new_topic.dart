import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../../../controller/controller_account_information.dart';
import '../../../../controller/controller_forum.dart';
import '../../../../widgets/text%20form%20field/custom_textformfield.dart';

import '../../../../constant/constant_colors.dart';
import '../../../../widgets/appbar title/appbar_title.dart';

// Validation Key
final _validationKey = GlobalKey<FormState>();

class OpenNewTopic extends StatefulWidget {
  const OpenNewTopic({Key? key}) : super(key: key);

  @override
  State<OpenNewTopic> createState() => _OpenNewTopicState();
}

class _OpenNewTopicState extends State<OpenNewTopic> {
  final TextEditingController titleCtrlr = TextEditingController();
  final TextEditingController descriptionCtrlr = TextEditingController();
  final ControllerForum forum = Get.put(ControllerForum());
  bool fieldIsValid = false;
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
          title: 'Open Topic',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Form(
                key: _validationKey,
                onChanged: () => setState(() =>
                    fieldIsValid = _validationKey.currentState!.validate()),
                child: Column(
                  children: [
                    CustomTextFormField(
                      maxLine: 1,
                      ctrlr: titleCtrlr,
                      hint: 'Title...',
                      isPassword: false,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Title is required 😊';
                        }
                        if (value.toString().length < 8) {
                          return 'Title should be at least 8 character 😊';
                        }
                      },
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    CustomTextFormField(
                      minimumLine: 5,
                      maxLine: 15,
                      ctrlr: descriptionCtrlr,
                      hint: 'Description...',
                      isPassword: false,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Description is required 😊';
                        }
                        if (value.toString().length < 20) {
                          return 'Description must be at least 20 character 😊';
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              buildPublishRequestButton(
                hint: 'Publish My Request 📣',
                onClicked: () async {
                  await forum.forumTopicRequest(
                      requestedBy: currentProfileName.toString(),
                      requesterProfileImageUrl:
                          currentProfileImageUrl.toString(),
                      requesterUid: currentUserId.toString(),
                      topicTitle: titleCtrlr.text,
                      topicDescription: descriptionCtrlr.text);
                },
                isFormValid: fieldIsValid,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

TextButton buildPublishRequestButton({
  required VoidCallback onClicked,
  required String hint,
  required bool isFormValid,
}) {
  return TextButton(
      style: TextButton.styleFrom(
        primary: isFormValid ? Colors.white : Get.theme.disabledColor,
        backgroundColor: isFormValid ? Get.theme.primaryColor : null,
      ),
      onPressed: isFormValid ? onClicked : null,
      child: Text(
        hint,
        textScaleFactor: 1.1,
      ));
}
