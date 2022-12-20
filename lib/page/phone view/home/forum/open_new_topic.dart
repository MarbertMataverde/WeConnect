import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../../../widgets/appbar/build_appbar.dart';
import '../../../../controller/controller_account_information.dart';
import '../../../../controller/controller_forum.dart';
import '../../../../widgets/text%20form%20field/custom_textformfield.dart';

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
      appBar: buildAppBar(
          context: context,
          title: 'Open Topic',
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
              tooltip: 'Send Request',
              onPressed: fieldIsValid
                  ? () async {
                      await forum.forumTopicRequest(
                          context: context,
                          requestedBy: currentProfileName.toString(),
                          requesterProfileImageUrl:
                              currentProfileImageUrl.toString(),
                          requesterUid: currentUserId.toString(),
                          topicTitle: titleCtrlr.text,
                          topicDescription: descriptionCtrlr.text);
                    }
                  : null,
              icon: Icon(
                Iconsax.direct_send,
                color: fieldIsValid
                    ? Theme.of(context).iconTheme.color
                    : Theme.of(context).disabledColor,
              ),
            ),
          ]),
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
                          return 'Title is required';
                        }
                        if (value.toString().length < 8) {
                          return 'Title should be at least 8 character';
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
                          return 'Description is required';
                        }
                        if (value.toString().length < 20) {
                          return 'Description must be at least 20 character';
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
