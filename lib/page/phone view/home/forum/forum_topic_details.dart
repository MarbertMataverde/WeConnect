import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:linkwell/linkwell.dart';
import 'package:sizer/sizer.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../../controller/controller_vote.dart';
import '../../../../widgets/appbar/appbar_title.dart';
import '../../../phone%20view/home/forum/forum_comment_list.dart';
import '../../../../constant/constant.dart';
import '../../../../controller/controller_account_information.dart';
import '../../../../controller/controller_forum.dart';

import '../../../../../constant/constant_colors.dart';

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
  @override
  Widget build(BuildContext context) {
    int likeCount = topicVotes.length;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: const AppBarTitle(
          title: 'Topic Details',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  //profile image
                  CircleAvatar(
                    radius: Get.mediaQuery.size.width * 0.07,
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      child: FadeInImage.assetNetwork(
                        placeholder: randomAvatarImageAsset(),
                        image: requesterProfileImageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
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
                          ? await removeVote(
                              collection: 'forum',
                              docName: 'approved-request',
                              subCollection: 'all-approved-request',
                              topicDocId: topicDocId,
                              currentUid: [currentUserId],
                            )
                          : await addVote(
                              collection: 'forum',
                              docName: 'approved-request',
                              subCollection: 'all-approved-request',
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
              Divider(
                height: 2.h,
                color: Get.isDarkMode
                    ? kButtonColorDarkTheme
                    : kButtonColorLightTheme,
              ),
              // ignore: prefer_const_constructors
              TextButton.icon(
                onPressed: () {
                  Get.to(() => ForumCommentList(
                        topicDocId: topicDocId,
                      ));
                },
                style: TextButton.styleFrom(
                  primary: Get.theme.primaryColor,
                  fixedSize: Size.fromWidth(100.w),
                ),
                icon: const Icon(MdiIcons.commentOutline),
                label: const Text('Write Comment'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
