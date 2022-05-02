import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/controller/controller_account_information.dart';
import 'package:weconnect/controller/controller_help_and_feedback.dart';
import 'package:weconnect/widgets/appbar/build_appbar.dart';
import 'package:weconnect/widgets/global%20spinkit/global_spinkit.dart';
import 'package:weconnect/widgets/text%20form%20field/custom_textformfield.dart';

// Validation Key
final _validationKey = GlobalKey<FormState>();

//controller
final hf = Get.put(ControllerHelpAndFeedback());

class HelpAndFeedback extends StatefulWidget {
  const HelpAndFeedback({Key? key}) : super(key: key);

  @override
  State<HelpAndFeedback> createState() => _HelpAndFeedbackState();
}

class _HelpAndFeedbackState extends State<HelpAndFeedback> {
  bool sendIconButtonIsEnable = false;
  bool isSending = false;
  late TextEditingController helpAndFeedbackCtrlr;

  @override
  void initState() {
    super.initState();
    helpAndFeedbackCtrlr = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    helpAndFeedbackCtrlr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          context: context,
          title: 'Help & Feedback',
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
            isSending
                ? Padding(
                    padding: EdgeInsets.only(right: 2.5.w),
                    child: buildGlobalSpinkit(context: context),
                  )
                : IconButton(
                    onPressed: () async {
                      setState(() => isSending = true);
                      await hf.sendHelpAndFeedbackData(
                        senderProfileImageUrl:
                            currentProfileImageUrl.toString(),
                        senderName: currentProfileName.toString(),
                        senderMessage: helpAndFeedbackCtrlr.text,
                      );
                      Future.delayed(
                        const Duration(seconds: 1),
                        () {
                          setState(() => isSending = false);
                          Navigator.pop(context);
                        },
                      );
                    },
                    icon: Icon(
                      Iconsax.sms_tracking,
                      color: sendIconButtonIsEnable
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).disabledColor,
                    ),
                  ),
          ]),
      body: Column(
        children: [
          SizedBox(
            height: 3.h,
          ),
          Text(
            'Hi $currentProfileName! what do you want say?',
            textScaleFactor: 1.2,
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
            child: Form(
              key: _validationKey,
              onChanged: () => setState(() => sendIconButtonIsEnable =
                  _validationKey.currentState!.validate()),
              child: CustomTextFormField(
                ctrlr: helpAndFeedbackCtrlr,
                isPassword: false,
                minimumLine: 8,
                maxLine: 12,
                hint: 'Your concern or feedback here...',
                validator: (value) {
                  if (value.isEmpty) {
                    return 'This cannot be empty';
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
