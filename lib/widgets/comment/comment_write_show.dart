import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
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
  }) : super(key: key);
  //*DATE FORMATER
  final String postDocId;
  final String collectionName;
  final String docName;

  @override
  State<ShowAllComment> createState() => _ShowAllCommentState();
}

class _ShowAllCommentState extends State<ShowAllComment> {
  DateFormat dateFormat = DateFormat('yyyy-MM-dd – kk:mm');

  final box = GetStorage();

  final TextEditingController _commentController = TextEditingController();

  final _addComment = Get.put(ControllerWritePostComment());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SpinKitSpinningLines(color: Get.theme.primaryColor);
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
          Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
              child: TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    if (value.isEmpty) {
                      return 'Please Enter Comment 📝';
                    }
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(
                  color: Get.isDarkMode
                      ? kTextColorDarkTheme
                      : kTextColorLightTheme,
                  fontSize: 10.sp,
                ),
                autofocus: false,
                controller: _commentController,
                //*Making the text multiline
                maxLines: 12,
                minLines: 1,
                keyboardType: TextInputType.multiline,
                //*Decoration
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  //*Making the text padding to zero
                  contentPadding: const EdgeInsets.only(left: 10),
                  //*Hint Text
                  hintText: 'Write your comment here ✏',
                  suffixIcon: IconButton(
                    splashColor: Colors.white,
                    color: Get.isDarkMode
                        ? kTextColorDarkTheme
                        : kTextColorLightTheme,
                    onPressed: () async {
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
                    icon: const Icon(Icons.send_rounded),
                  ),
                  hintStyle: TextStyle(
                    color: Get.isDarkMode
                        ? kTextColorDarkTheme
                        : kTextColorLightTheme,
                    fontWeight: FontWeight.w700,
                    fontSize: 10.sp,
                  ),
                  //*Filled Color
                  filled: true,
                  fillColor: Get.isDarkMode
                      ? kTextFormFieldColorDarkTheme
                      : kTextFormFieldColorLightTheme,
                  //*Enabled Border
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
