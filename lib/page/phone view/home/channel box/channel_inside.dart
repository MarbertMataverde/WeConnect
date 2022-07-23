import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../phone%20view/home/channel%20box/channel_announcement_tile.dart';
import '../../../../widgets/appbar/build_appbar.dart';
import '../../../../widgets/global%20spinkit/global_spinkit.dart';
import '../../../../widgets/text%20form%20field/custom_textformfield.dart';

import '../../../../dialog/dialog_channel.dart';
import '../../../../controller/controller_account_information.dart';
import '../../../../controller/controller_getx.dart';
import '../../../phone%20view/home/channel%20box/channel_settings.dart';

class ChannelInside extends StatefulWidget {
  const ChannelInside({
    Key? key,
    required this.channelName,
    required this.token,
    required this.channelAvatarImage,
    required this.channelDocId,
  }) : super(key: key);

  //channel name
  final String channelName;
  //channel avatar image
  final String channelAvatarImage;
  //channel doc id
  final String token;
  final String channelDocId;

  @override
  State<ChannelInside> createState() => _ChannelInsideState();
}

class _ChannelInsideState extends State<ChannelInside> {
  //controllers
  late TextEditingController announcementCtrlr;
  @override
  void initState() {
    super.initState();
    announcementCtrlr = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    announcementCtrlr.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> channelAnnouncementsStream = FirebaseFirestore
        .instance
        .collection('channels')
        .doc(widget.token)
        .collection('channel-announcements')
        .orderBy('announcement-created-at', descending: false)
        .snapshots();
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: widget.channelName,
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
              onPressed: () {
                Get.to(() => ChannelSettings(
                      channelToken: widget.token,
                      channelAvatarImage: widget.channelAvatarImage,
                      channelName: widget.channelName,
                      channelDocId: widget.channelDocId,
                    ));
              },
              icon: Icon(
                Iconsax.setting,
                color: Theme.of(context).iconTheme.color,
              ))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: channelAnnouncementsStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return buildGlobalSpinkit(context: context);
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
                          context: context,
                          announcementMessage: data.docs[index]
                              ['announcement-message'],
                          fileUrl: data.docs[index]['announcement-file-urls'],
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
                  vertical: MediaQuery.of(context).size.height * 0.01),
              child: Row(
                children: [
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          GetBuilder<ControllerGetX>(builder: (controller) {
                            return controller.textFieldEmptyUpload
                                ? Row(
                                    children: [
                                      GetBuilder<ControllerGetX>(
                                          builder: (selectFileController) {
                                        return IconButton(
                                          splashRadius: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                          onPressed: selectFileController
                                                  .fileIconButtonEnable
                                              ? () {
                                                  selectFile().whenComplete(() {
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
                                          icon: Icon(Iconsax.document_text,
                                              color: selectFileController
                                                      .fileIconButtonEnable
                                                  ? Theme.of(context)
                                                      .iconTheme
                                                      .color
                                                  : Theme.of(context)
                                                      .disabledColor),
                                        );
                                      }),
                                      GetBuilder<ControllerGetX>(
                                          builder: (selectImageController) {
                                        return IconButton(
                                            splashRadius: MediaQuery.of(context)
                                                    .size
                                                    .width *
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
                                              Iconsax.gallery_add,
                                              color: selectImageController
                                                      .imageIconButtonEnable
                                                  ? Theme.of(context)
                                                      .iconTheme
                                                      .color
                                                  : Theme.of(context)
                                                      .disabledColor,
                                            ));
                                      }),
                                    ],
                                  )
                                : IconButton(
                                    onPressed: () {
                                      getxContoller
                                          .emptyTextFieldForUploadButton(true);
                                    },
                                    icon: Icon(
                                      Iconsax.arrow_right,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                  );
                          }),
                          Expanded(
                            child: CustomTextFormField(
                              ctrlr: announcementCtrlr,
                              isPassword: false,
                              minimumLine: 1,
                              maxLine: 5,
                              hint: 'Write Announcement...',
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
                            ),
                          ),
                          GetBuilder<ControllerGetX>(builder: (controller) {
                            return IconButton(
                              splashRadius:
                                  MediaQuery.of(context).size.width * 0.05,
                              onPressed: controller.filesEmpty &&
                                      controller.textFieldEmptySend
                                  ? null
                                  : () async {
                                      await channel.uploadAnnouncement(
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
                                controller.filesEmpty &&
                                        controller.textFieldEmptySend
                                    ? Iconsax.send_1
                                    : Iconsax.send_2,
                                color: controller.filesEmpty &&
                                        controller.textFieldEmptySend
                                    ? Theme.of(context).disabledColor
                                    : Theme.of(context).primaryColor,
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
