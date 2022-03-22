import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../../widgets/appbar/appbar_back.dart';

import '../../../../dialog/dialog_channel.dart';
import '../../../../widgets/appbar/appbar_title.dart';
import '../../../phone%20view/home/channel%20box/channel_announcement_tiles.dart';
import '../../../../constant/constant.dart';
import '../../../../controller/controller_account_information.dart';
import '../../../../controller/controller_getx.dart';
import '../../../phone%20view/home/channel%20box/channel_settings.dart';

import '../../../../constant/constant_colors.dart';
import '../../../../constant/constant_login_page.dart';

class ChannelInside extends StatefulWidget {
  const ChannelInside(
      {Key? key,
      required this.channelName,
      required this.token,
      required this.channelAvatarImage})
      : super(key: key);

  //channel name
  final String channelName;
  //channel avatar image
  final String channelAvatarImage;
  //channel doc id
  final String token;

  @override
  State<ChannelInside> createState() => _ChannelInsideState();
}

class _ChannelInsideState extends State<ChannelInside> {
  //controllers
  final TextEditingController announcementCtrlr = TextEditingController();
  final getxContoller = Get.put(ControllerGetX());
  //image picker
  FilePickerResult? pickedImage;
  Future<void> selectImage() async {
    pickedImage = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      allowedExtensions: ['png', 'jpg'],
      type: FileType.custom,
    );
  }

  //file picker
  FilePickerResult? pickedFile;
  Future<void> selectFile() async {
    pickedFile = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: ['pdf', 'doc', 'xlsx', 'ppt'],
      type: FileType.custom,
    );
  }

  //is focused?
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _channelAnnouncementsStream = FirebaseFirestore
        .instance
        .collection('channels')
        .doc(widget.token)
        .collection('channel-announcements')
        .orderBy('announcement-created-at', descending: false)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: buildAppbarBackButton(),
        centerTitle: true,
        title: AppBarTitle(
          title: widget.channelName,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => ChannelSettings(
                      channelAvatarImage: widget.channelAvatarImage,
                      channelName: widget.channelName,
                    ));
              },
              icon: Icon(
                Icons.settings_outlined,
                color: Get.isDarkMode
                    ? kButtonColorDarkTheme
                    : kButtonColorLightTheme,
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _channelAnnouncementsStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SpinKitSpinningLines(color: Get.theme.primaryColor);
                }
                final data = snapshot.requireData;
                return SingleChildScrollView(
                  reverse: true,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.size,
                    itemBuilder: (context, index) {
                      return channelTile(
                          announcementMessage: data.docs[index]
                              ['announcement-message'],
                          announcementFileList: data.docs[index]
                              ['announcement-file-urls'],
                          announcementImageList: data.docs[index]
                              ['announcement-image-urls'],
                          announcementCreatedAt: data.docs[index]
                              ['announcement-created-at']);
                    },
                  ),
                );
              },
            ),
          ),
          Visibility(
            visible: currentAccountType == 'accountTypeProfessor',
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Get.mediaQuery.size.height * 0.01),
              child: Row(
                children: [
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: SizedBox(
                      width: Get.mediaQuery.size.width,
                      child: Row(
                        children: [
                          GetBuilder<ControllerGetX>(builder: (controller) {
                            return controller.textFieldEmptyUpload
                                ? Row(
                                    children: [
                                      GetBuilder<ControllerGetX>(
                                          builder: (selectFileController) {
                                        return IconButton(
                                            splashRadius:
                                                Get.mediaQuery.size.width *
                                                    0.05,
                                            onPressed: selectFileController
                                                    .fileIconButtonEnable
                                                ? () {
                                                    selectFile()
                                                        .whenComplete(() {
                                                      if (pickedFile != null) {
                                                        getxContoller
                                                            .emptyFilesForSendButton(
                                                                false);
                                                        getxContoller
                                                            .reEnableSelectImageIconButton(
                                                                false);
                                                      } else {
                                                        getxContoller
                                                            .emptyFilesForSendButton(
                                                                true);
                                                        getxContoller
                                                            .reEnableSelectImageIconButton(
                                                                true);
                                                      }
                                                    });
                                                  }
                                                : null,
                                            icon: Icon(
                                              MdiIcons.filePlusOutline,
                                              color: selectFileController
                                                      .fileIconButtonEnable
                                                  ? Get.isDarkMode
                                                      ? kButtonColorDarkTheme
                                                      : kButtonColorLightTheme
                                                  : Get.theme.disabledColor,
                                            ));
                                      }),
                                      GetBuilder<ControllerGetX>(
                                          builder: (selectImageController) {
                                        return IconButton(
                                            splashRadius:
                                                Get.mediaQuery.size.width *
                                                    0.05,
                                            onPressed: selectImageController
                                                    .imageIconButtonEnable
                                                ? () {
                                                    selectImage()
                                                        .whenComplete(() {
                                                      if (pickedImage != null) {
                                                        getxContoller
                                                            .emptyFilesForSendButton(
                                                                false);
                                                        getxContoller
                                                            .reEnableSelectFileIconButton(
                                                                false);
                                                      } else {
                                                        getxContoller
                                                            .emptyFilesForSendButton(
                                                                true);
                                                        getxContoller
                                                            .reEnableSelectFileIconButton(
                                                                true);
                                                      }
                                                    });
                                                  }
                                                : null,
                                            icon: Icon(
                                              MdiIcons.fileImagePlusOutline,
                                              color: selectImageController
                                                      .imageIconButtonEnable
                                                  ? Get.isDarkMode
                                                      ? kButtonColorDarkTheme
                                                      : kButtonColorLightTheme
                                                  : Get.theme.disabledColor,
                                            ));
                                      }),
                                    ],
                                  )
                                : IconButton(
                                    onPressed: () {
                                      getxContoller
                                          .emptyTextFieldForUploadButton(true);
                                    },
                                    icon: const Icon(
                                      MdiIcons.arrowRightDropCircleOutline,
                                    ));
                          }),
                          Expanded(
                            child: buildAnnouncementTextFormField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  getxContoller.emptyTextFieldForSendButton(
                                      value.isEmpty);
                                  getxContoller.emptyTextFieldForUploadButton(
                                      value.isEmpty);
                                } else {
                                  getxContoller.emptyTextFieldForSendButton(
                                      value.isEmpty);
                                  getxContoller.emptyTextFieldForUploadButton(
                                      value.isEmpty);
                                }
                                return null;
                              },
                              ctrlr: announcementCtrlr,
                            ),
                          ),
                          GetBuilder<ControllerGetX>(builder: (controller) {
                            return IconButton(
                              splashRadius: Get.mediaQuery.size.width * 0.05,
                              onPressed: controller.filesEmpty &&
                                      controller.textFieldEmptySend
                                  ? null
                                  : () async {
                                      channel.uploadAnnouncement(
                                        token: widget.token,
                                        channelName: widget.channelName,
                                        adminName:
                                            currentProfileName.toString(),
                                        announcementMessage:
                                            announcementCtrlr.text.isEmpty
                                                ? ''
                                                : announcementCtrlr.text,
                                        imagePicked: pickedImage,
                                        filePicked: pickedFile,
                                      );
                                      announcementCtrlr.clear();
                                      pickedImage?.files.clear();
                                      pickedFile?.files.clear();
                                      getxContoller
                                          .emptyFilesForSendButton(true);
                                      getxContoller
                                          .reEnableSelectFileIconButton(true);
                                      getxContoller
                                          .reEnableSelectImageIconButton(true);
                                    },
                              icon: Icon(
                                MdiIcons.sendOutline,
                                color: controller.filesEmpty &&
                                        controller.textFieldEmptySend
                                    ? Get.theme.disabledColor
                                    : Get.theme.primaryColor,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget buildAnnouncementTextFormField({
  required String? Function(String?)? validator,
  required TextEditingController ctrlr,
}) {
  return TextFormField(
    minLines: 1,
    maxLines: 5,
    validator: validator,
    keyboardType: TextInputType.text,
    controller: ctrlr,
    style: kLoginPageTextFormFieldTextStyle,
    cursorColor: Get.isDarkMode
        ? kTextFormFieldCursorColorDarkTheme
        : kTextFormFieldCursorColorLightTheme,
    decoration: InputDecoration(
      errorStyle: TextStyle(
        color: Get.theme.primaryColor.withAlpha(180),
      ),
      filled: kTrue,
      fillColor: Get.isDarkMode
          ? kTextFormFieldColorDarkTheme
          : kTextFormFieldColorLightTheme,
      hintText: 'Write announcement 🔥',
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
    ),
  );
}
