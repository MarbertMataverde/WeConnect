import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:linkwell/linkwell.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/widgets/comment/comment_form.dart';
import '../../constant/constant.dart';
import '../../controller/controller_account_information.dart';

import '../../constant/constant_colors.dart';
import '../../controller/controller_write_post_comment.dart';
import '../appbar title/appbar_title.dart';
import 'comment_tile.dart';

class ShowAllComment extends StatefulWidget {
  const ShowAllComment({
    Key? key,
    required this.postDocId,
    required this.collectionName,
    required this.docName,
    required this.profileImageUrl,
    required this.profileName,
    required this.postDescription,
  }) : super(key: key);
  final String postDocId;
  final String collectionName;
  final String docName;

  //post profile image and description
  final String profileImageUrl;
  final String profileName;
  final String postDescription;

  @override
  State<ShowAllComment> createState() => _ShowAllCommentState();
}

class _ShowAllCommentState extends State<ShowAllComment> {
  DateFormat dateFormat = DateFormat('yyyy-MM-dd – kk:mm');

  final TextEditingController _commentController = TextEditingController();

  final _addComment = Get.put(ControllerWritePostComment());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool isExpanded = false;

    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection(widget.collectionName)
        .doc(widget.docName)
        .collection('post')
        .doc(widget.postDocId)
        .collection('comments')
        .orderBy('created-at', descending: true)
        .snapshots();
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
          title: 'Comments',
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                constraints: BoxConstraints(
                  minHeight: 0.h,
                  maxHeight: 60.h,
                ),
                child: SingleChildScrollView(
                  child: ListTile(
                    leading: //profile image
                        CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                        child: FadeInImage.assetNetwork(
                          placeholder: randomAvatarImageAsset(),
                          image: widget.profileImageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      widget.profileName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: widget.postDescription.length < 600
                        ? LinkWell(
                            widget.postDescription,
                            style: TextStyle(
                              color: Get.isDarkMode
                                  ? kTextColorDarkTheme
                                  : kTextColorLightTheme,
                            ),
                            linkStyle: TextStyle(
                              color: Get.theme.primaryColor,
                            ),
                          )
                        : ExpandableText(
                            widget.postDescription,
                            animationDuration:
                                const Duration(milliseconds: 1500),
                            style: TextStyle(
                              color: Get.isDarkMode
                                  ? kTextColorDarkTheme
                                  : kTextColorLightTheme,
                            ),
                            maxLines: 5,
                            expandText: 'read more 📖',
                            expandOnTextTap: true,
                            collapseOnTextTap: true,
                            collapseText: 'collapse 📕',
                            animation: true,
                            animationCurve: Curves.fastLinearToSlowEaseIn,
                          ),
                  ),
                ),
              ),
              Divider(
                height: 2.h,
                color: Get.isDarkMode
                    ? kButtonColorDarkTheme
                    : kButtonColorLightTheme,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _usersStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: Text('Something went wrong'));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SpinKitSpinningLines(
                          color: Get.theme.primaryColor);
                    }
                    final data = snapshot.requireData;
                    return ListView.builder(
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        return buildCommentTile(
                            profileImageUrl: data.docs[index]['profile-url'],
                            profileName: data.docs[index]['profile-name'],
                            commentedDate: data.docs[index]['created-at'],
                            comment: data.docs[index]['comment']);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Get.theme.scaffoldBackgroundColor,
              child: buildCommentForm(
                  formKey: _formKey,
                  onSend: () async {
                    final _isValid = _formKey.currentState!.validate();

                    if (_isValid == true) {
                      await _addComment.writeCommentToCampusPost(
                        widget.collectionName, //? COLLECTION NAME
                        widget.docName, //? DOCUMENT NAME
                        _commentController.text,
                        currentProfileImageUrl.toString(),
                        currentProfileName.toString(),
                        widget.postDocId,
                        Timestamp.now(),
                      );
                      _commentController.clear();
                      Get.focusScope!.unfocus();
                    }
                  },
                  textEditingCtrlr: _commentController),
            ),
          ),
        ],
      ),
    );
  }
}
