import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/widgets/appbar/build_appbar.dart';
import '../../../../widgets/text%20form%20field/custom_textformfield.dart';

import '../../../../controller/controller_create_post.dart';

//upload post controller
final _createPost = Get.put(ControllerCreatePost());

// Validation Key
final _validationKey = GlobalKey<FormState>();

class UploadFeedPost extends StatefulWidget {
  const UploadFeedPost(
      {Key? key, required this.collectionName, required this.docName})
      : super(key: key);
  final String collectionName;
  final String docName;

  @override
  State<UploadFeedPost> createState() => _UploadFeedPostState();
}

class _UploadFeedPostState extends State<UploadFeedPost> {
  final TextEditingController _descriptionCtrlr = TextEditingController();

  //is upload button enable or not
  bool uploadButtonEnable = false;
  bool isLoading = false;

  FilePickerResult? result;
  Future<void> pickImages() async {
    result = await FilePicker.platform.pickFiles(
      allowCompression: true,
      allowMultiple: true,
      allowedExtensions: ['png', 'jpg'],
      type: FileType.custom,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: 'New Post',
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
            onPressed: uploadButtonEnable && result != null
                ? () async {
                    setState(() {
                      isLoading = true;
                    });
                    SharedPreferences _sp =
                        await SharedPreferences.getInstance();
                    await _createPost.dataChecker(
                      result,
                      widget.collectionName,
                      _descriptionCtrlr.text,
                      _sp.get('currentProfileName') as String,
                      _sp.get('currentProfileImageUrl') as String,
                      _sp.get('accountType') as String,
                      widget.docName,
                    );
                    setState(() {
                      isLoading = false;
                    });
                  }
                : null,
            icon: Icon(
              Iconsax.direct_send,
              color: uploadButtonEnable && result != null
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).disabledColor,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Form(
                      key: _validationKey,
                      onChanged: () => setState(() => uploadButtonEnable =
                          _validationKey.currentState!.validate()),
                      child: CustomTextFormField(
                        ctrlr: _descriptionCtrlr,
                        hint: 'Announcement Description...',
                        isPassword: false,
                        minimumLine: 12,
                        maxLine: null,
                        keyboardType: TextInputType.multiline,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Description name is required 📜';
                          }
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        pickImages();
                      },
                      icon: Icon(
                        Iconsax.gallery_add,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
