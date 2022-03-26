import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/widgets/appbar/build_appbar.dart';
import 'package:weconnect/widgets/text%20form%20field/custom_textformfield.dart';

import '../../../../dialog/dialog_post_tile_.dart';

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
      appBar: buildAppBar(
        context: context,
        title: 'Edit Caption',
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
              Iconsax.tick_square,
              color: Theme.of(context).primaryColor,
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
              CustomTextFormField(
                initialValue: widget.recentCaption,
                minimumLine: 12,
                maxLine: null,
                onChanged: (value) {
                  updatedCaption = value.toString();
                },
                isPassword: false,
                validator: (_) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
