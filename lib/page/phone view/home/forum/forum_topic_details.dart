import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:linkwell/linkwell.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/widgets/appbar/build_appbar.dart';
import '../../../../controller/controller_vote.dart';
import '../../../../dialog/dialog_forum.dart';
import '../../../phone%20view/home/forum/forum_comment_list.dart';
import '../../../../constant/constant.dart';
import '../../../../controller/controller_account_information.dart';
import '../../../../controller/controller_forum.dart';

final ControllerForum forum = Get.put(ControllerForum());
final _dialog = Get.put(DialogForum());

class ForumTopicDetails extends StatefulWidget {
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
  State<ForumTopicDetails> createState() => _ForumTopicDetailsState();
}

class _ForumTopicDetailsState extends State<ForumTopicDetails> {
  //controller
  final TextEditingController commentCtrlr = TextEditingController();
  bool isFabVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: 'Details',
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Iconsax.arrow_square_left,
              color: Theme.of(context).iconTheme.color,
            )),
        actions: currentAccountType == 'accountTypeCampusAdmin' ||
                currentAccountType == 'accountTypeRegistrarAdmin'
            ? [
                IconButton(
                  onPressed: () async {
                    await _dialog.deleteTopicDialog(
                      context,
                      assetLocation: 'assets/gifs/question_mark.gif',
                      title: 'Topic Deletion',
                      description:
                          'You\'re about to delete this topic, click okay to continue.',
                      topicDocId: widget.topicDocId,
                    );
                  },
                  icon: Icon(
                    Iconsax.trash,
                    color: Colors.red.shade300,
                  ),
                ),
              ]
            : null,
      ),
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.forward) {
            setState(() => isFabVisible = true);
          } else if (notification.direction == ScrollDirection.reverse) {
            setState(() => isFabVisible = false);
          }
          return true;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    //profile image
                    CircleAvatar(
                      radius: MediaQuery.of(context).size.width * 0.07,
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                        child: FadeInImage.assetNetwork(
                          placeholder: randomAvatarImageAsset(),
                          image: widget.requesterProfileImageUrl,
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
                          widget.requestedBy,
                          textScaleFactor: 1.2,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                        ),
                        Text(
                          DateFormat('d MMM yyyy').format(
                            widget.topicApprovedDate.toDate(),
                          ),
                          textScaleFactor: 0.8,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color:
                                Theme.of(context).textTheme.labelMedium!.color,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    LikeButton(
                      circleColor: const CircleColor(
                          start: Colors.yellow, end: Colors.cyan),
                      bubblesColor: BubblesColor(
                        dotPrimaryColor: Theme.of(context).primaryColor,
                        dotSecondaryColor: Colors.red,
                      ),
                      likeBuilder: (isLiked) => Icon(
                        widget.topicVotes.isEmpty
                            ? Iconsax.heart
                            : Iconsax.lovely,
                        color: isLiked ? Colors.red : Colors.grey,
                        size: 20.sp,
                      ),
                      likeCountPadding: EdgeInsets.only(left: 2.5.w),
                      likeCount: widget.topicVotes.length,
                      countBuilder: (count, isLiked, text) {
                        final color = isLiked ? Colors.red : Colors.grey;
                        return Text(
                          text,
                          style: TextStyle(
                            color: color,
                          ),
                        );
                      },
                      isLiked: widget.topicVotes.contains(currentUserId),
                      onTap: (isLiked) async {
                        isLiked
                            ? await removeVote(
                                collection: 'forum',
                                docName: 'approved-request',
                                subCollection: 'all-approved-request',
                                topicDocId: widget.topicDocId,
                                currentUid: [currentUserId],
                              )
                            : await addVote(
                                collection: 'forum',
                                docName: 'approved-request',
                                subCollection: 'all-approved-request',
                                topicDocId: widget.topicDocId,
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
                  widget.topicTitle,
                  textScaleFactor: 1.3,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                LinkWell(
                  widget.topicDescription,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                  linkStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: isFabVisible
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(Iconsax.message_add),
              onPressed: () {
                Get.to(
                  () => ForumCommentList(
                    topicDocId: widget.topicDocId,
                  ),
                );
              },
            )
          : null,
    );
  }
}
