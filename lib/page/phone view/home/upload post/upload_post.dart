import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../../widgets/global%20spinkit/global_spinkit.dart';
import '../../../../widgets/appbar/build_appbar.dart';
import '../../../../widgets/text%20form%20field/custom_textformfield.dart';
import 'package:path/path.dart' as b;

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
  late final TextEditingController _descriptionCtrlr;

  @override
  void initState() {
    super.initState();
    _descriptionCtrlr = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionCtrlr.dispose();
  }

  //is upload button enable or not
  bool uploadButtonEnable = false;
  bool isLoading = false;

  FilePickerResult? result;
  Future<void> pickImages() async {
    result = await FilePicker.platform
        .pickFiles(
      allowCompression: true,
      allowMultiple: true,
      allowedExtensions: ['png', 'jpg', 'gif'],
      type: FileType.custom,
    )
        .whenComplete(() {
      setState(() {});
    });
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
          isLoading
              ? Padding(
                  padding: EdgeInsets.only(right: 5.w),
                  child: buildGlobalSpinkit(context: context),
                )
              : IconButton(
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
                            return 'Description is required 📜';
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
                Divider(
                  height: 5.h,
                ),
                result == null
                    ? const Text('Selected image here')
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.height,
                        child: GridView.builder(
                          itemCount: result!.count,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      (MediaQuery.of(context).orientation ==
                                              Orientation.portrait)
                                          ? 2
                                          : 3),
                          itemBuilder: (context, index) {
                            List<File> files = result!.paths
                                .map((path) => File(path!))
                                .toList();
                            return Padding(
                              padding: EdgeInsets.all(1.w),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(
                                    () => ZoomInImage(
                                      image: files[index],
                                      tag: index,
                                      path: files[index].path,
                                    ),
                                  );
                                },
                                child: Hero(
                                  flightShuttleBuilder: flightShuttleBuilder,
                                  tag: index,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(1.h)),
                                    child: Stack(
                                      children: [
                                        Image.file(
                                          files[index],
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          bottom: 0,
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.040,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: const Color.fromARGB(
                                                72, 0, 0, 0),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: 1.h,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 2.w),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.30,
                                              child: Text(
                                                b.basename(files[index]
                                                    .path), // getting just the file base name
                                                textScaleFactor: 0.8,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ZoomInImage extends StatelessWidget {
  const ZoomInImage(
      {Key? key, required this.image, required this.tag, required this.path})
      : super(key: key);

  final File image;
  final Object tag;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Hero(
          tag: tag,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Stack(children: [
              Image.file(image),
              Positioned(
                bottom: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.040,
                  width: MediaQuery.of(context).size.width,
                  color: const Color.fromARGB(72, 0, 0, 0),
                ),
              ),
              Positioned(
                bottom: 1.h,
                child: SizedBox(
                  child: Text(
                    b.basename(path), // getting just the file base name
                    textScaleFactor: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

/// this fix the bug of hero layout drawing in transition
/// the bug is it shows red and yellow line in theres no scaffold widget in
/// widget tree
Widget flightShuttleBuilder(
  BuildContext flightContext,
  Animation<double> animation,
  HeroFlightDirection flightDirection,
  BuildContext fromHeroContext,
  BuildContext toHeroContext,
) {
  return DefaultTextStyle(
    style: DefaultTextStyle.of(toHeroContext).style,
    child: toHeroContext.widget,
  );
}
