import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:linkwell/linkwell.dart';
import 'package:sizer/sizer.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../../controller/controller_account_information.dart';
import '../../../../controller/controller_forum.dart';

import '../../../../../constant/constant_colors.dart';
import '../../../../../widgets/appbar title/appbar_title.dart';

final ControllerForum forum = Get.put(ControllerForum());

class ForumTopicDetails extends StatelessWidget {
  ForumTopicDetails({
    Key? key,
    required this.requesterProfileImageUrl,
    required this.requestedBy,
    required this.topicTitle,
    required this.topicDescription,
    required this.topicApprovedDate,
    required this.topicDocId,
    required this.requesterUid,
    required this.topicVotes,
  }) : super(key: key);

  final String requesterProfileImageUrl;
  final String requestedBy;
  final String topicTitle;
  final String topicDescription;
  final String requesterUid;
  final Timestamp topicApprovedDate;
  final List topicVotes;

  //request dismissal
  final String topicDocId;
  //controller
  final TextEditingController commentCtrlr = TextEditingController();
  //key
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    int likeCount = topicVotes.length;
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
          title: 'Topic Details',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: Get.mediaQuery.size.width * 0.07,
                          backgroundImage:
                              NetworkImage(requesterProfileImageUrl),
                        ),
                        SizedBox(
                          width: 3.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              requestedBy,
                              textScaleFactor: 1.2,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              DateFormat('d MMM yyyy').format(
                                topicApprovedDate.toDate(),
                              ),
                              textScaleFactor: 0.7,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Get.isDarkMode
                                    ? kTextColorDarkTheme
                                    : kTextColorLightTheme,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          splashRadius: 5.w,
                          icon: const Icon(
                            MdiIcons.commentText,
                          ),
                        ),
                        const Text(
                          '123',
                        ),
                        VerticalDivider(
                          color: Get.isDarkMode
                              ? kTextColorDarkTheme
                              : kTextColorLightTheme,
                        ),
                        LikeButton(
                          size: 20.sp,
                          circleColor: const CircleColor(
                              start: Colors.yellow, end: Colors.cyan),
                          bubblesColor: BubblesColor(
                            dotPrimaryColor: Get.theme.primaryColor,
                            dotSecondaryColor: Colors.red,
                          ),
                          likeBuilder: (isLiked) => Icon(
                            MdiIcons.heart,
                            color: isLiked ? Colors.red : Colors.grey,
                            size: 20.sp,
                          ),
                          likeCountPadding: EdgeInsets.only(left: 2.5.w),
                          likeCount: likeCount,
                          countBuilder: (count, isLiked, text) {
                            final color = isLiked ? Colors.red : Colors.grey;
                            return Text(
                              text,
                              style: TextStyle(
                                color: color,
                              ),
                            );
                          },
                          isLiked: topicVotes.contains(currentUserId),
                          onTap: (isLiked) async {
                            isLiked
                                ? await forum.removeVote(
                                    topicDocId: topicDocId,
                                    currentUid: [currentUserId],
                                  )
                                : await forum.addVote(
                                    topicDocId: topicDocId,
                                    currentUid: [currentUserId],
                                  );
                            return !isLiked;
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      topicTitle,
                      textScaleFactor: 1.3,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    LinkWell(
                      topicDescription,
                      style: TextStyle(
                        color: Get.isDarkMode
                            ? kTextColorDarkTheme
                            : kTextColorLightTheme,
                      ),
                      linkStyle: TextStyle(
                        color: Get.theme.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          buildNewComment(),
        ],
      ),
    );
  }

  Form buildNewComment() {
    return Form(
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
            color: Get.isDarkMode ? kTextColorDarkTheme : kTextColorLightTheme,
            fontSize: 10.sp,
          ),
          autofocus: false,
          controller: commentCtrlr,
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
              color:
                  Get.isDarkMode ? kTextColorDarkTheme : kTextColorLightTheme,
              onPressed: () async {},
              icon: const Icon(Icons.send_rounded),
            ),
            hintStyle: TextStyle(
              color:
                  Get.isDarkMode ? kTextColorDarkTheme : kTextColorLightTheme,
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
    );
  }
}
