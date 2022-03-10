import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:sizer/sizer.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:weconnect/controller/controller_account_information.dart';
import 'package:weconnect/controller/controller_forum.dart';
import 'package:weconnect/dialog/dialog_forum.dart';

import '../../../../../constant/constant_colors.dart';
import '../../../../../widgets/appbar title/appbar_title.dart';

final ControllerForum forum = Get.put(ControllerForum());

class ForumTopicDetails extends StatelessWidget {
  const ForumTopicDetails({
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
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: Get.mediaQuery.size.width * 0.07,
                      backgroundImage: NetworkImage(requesterProfileImageUrl),
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
                      likeCountPadding: EdgeInsets.symmetric(horizontal: 2.w),
                      likeCount: likeCount,
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
                Text(topicDescription),
              ],
            ),
          ),
        ));
  }
}
