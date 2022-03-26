import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/widgets/appbar/build_appbar.dart';
import '../../../../widgets/text%20form%20field/custom_textformfield.dart';
import '../../../../constant/constant_colors.dart';

import '../../../../controller/controller_create_post.dart';

//*THIS IS RESPONSIBLE FOR GETTING IMAGES
FilePickerResult? result;
Future<void> pickImages() async {
  result = await FilePicker.platform.pickFiles(
    allowCompression: true,
    allowMultiple: true,
    allowedExtensions: ['png', 'jpg'],
    type: FileType.custom,
  );
}

//upload post controller
final _createPost = Get.put(ControllerCreatePost());

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

  bool isLoading = false;

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
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              SharedPreferences _sp = await SharedPreferences.getInstance();
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
            },
            icon: Icon(
              Iconsax.direct_send,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
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
                    CustomTextFormField(
                      ctrlr: _descriptionCtrlr,
                      hint: 'Announcement Description...',
                      isPassword: false,
                      minimumLine: 12,
                      maxLine: null,
                      keyboardType: TextInputType.multiline,
                      validator: (_) {},
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      style: TextButton.styleFrom(
                          //style
                          primary: Get.isDarkMode
                              ? kTextColorDarkTheme
                              : kTextColorLightTheme),
                      onPressed: () {
                        pickImages();
                      },
                      label: const Text('CHOOSE IMAGE'),
                      icon: const Icon(Icons.image),
                    ),
                    isLoading
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const Text('Uploading Please Wait..'),
                                SpinKitThreeInOut(
                                  color: Get.theme.primaryColor,
                                  size: 30,
                                ),
                              ],
                            ),
                          )
                        : TextButton.icon(
                            style: TextButton.styleFrom(
                                //style
                                primary: Get.isDarkMode
                                    ? kTextColorDarkTheme
                                    : kTextColorLightTheme),
                            onPressed: () async {
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
                            },
                            label: const Text('UPLOAD NOW'),
                            icon: const Icon(Icons.upload),
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
