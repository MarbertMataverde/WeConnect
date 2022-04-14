import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../controller/controller_account_information.dart';

import '../../constant/constant.dart';
import '../../controller/controller_post_tile_pop_up_menu.dart';
import '../../controller/controller_vote.dart';
import '../../dialog/dialog_post_tile_.dart';
import '../../page/phone view/home/edit post caption/edit_caption.dart';
import '../../page/phone view/home/post details/post_details.dart';
import '../comment/comment_write_show.dart';

DateFormat dateFormat = DateFormat("MMM-dd");

//dialogs
final dialogs = Get.put(DialogPostTile());

class MasteralAnnouncementPostTile extends StatelessWidget {
  const MasteralAnnouncementPostTile({
    Key? key,
    required this.postCreatedAt,
    required this.accountName,
    required this.postCaption,
    required this.accountProfileImageUrl,
    required this.postMedia,
    //deletion constructor
    required this.announcementTypeDoc,
    required this.postDocId,
    required this.media,
    required this.accountType,
    required this.announcementVotes,
  }) : super(key: key);
  //when announcement post created
  final Timestamp postCreatedAt;
  //account name
  final String accountName;
  //description of the post
  final String postCaption;
  //account prifile image url
  final String accountProfileImageUrl;
  //post images or media
  final List postMedia;

  //delition data
  //announcement type like campus-feed, coa-feed like that so that we know where
  //to remove the specific post
  final String announcementTypeDoc;
  //post doc ID
  final String postDocId;
  //List of images with the post
  final List media;

  final String accountType;
  //list of voters uid
  final List announcementVotes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h, left: 2.w, right: 2.w),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 2.w, right: 2.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      //profile image
                      Container(
                        height: 10.w,
                        width: 10.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.w),
                          color: Colors.transparent,
                        ),
                        child: FadeInImage.assetNetwork(
                          placeholder: randomAvatarImageAsset(),
                          image: accountProfileImageUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //account name
                          Text(
                            accountName,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          //when post created with time ago format
                          Text(
                            timeago.format(postCreatedAt.toDate()),
                            style: TextStyle(
                              fontSize: 9.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  meneHolder(context),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpandableText(
                postCaption,
                animationDuration: const Duration(milliseconds: 1500),
                maxLines: 3,
                expandText: 'read more 📖',
                expandOnTextTap: true,
                collapseOnTextTap: true,
                collapseText: 'collapse 📕',
                animation: true,
                animationCurve: Curves.fastLinearToSlowEaseIn,
                linkColor: Theme.of(context).primaryColor,
              ),
            ),
            postMedia.length == 1
                ? GestureDetector(
                    onTap: () => Get.to(() => PostDetails(
                          postMedia: postMedia,
                          postCaption: postCaption,
                        )),
                    child: Image.network(
                      postMedia.first,
                      fit: BoxFit.contain,
                    ),
                  )
                : GestureDetector(
                    onTap: () => Get.to(() => PostDetails(
                          postMedia: postMedia,
                          postCaption: postCaption,
                        )),
                    child: CarouselSlider(
                      items: postMedia
                          .map(
                            (item) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1.w),
                              child: FadeInImage.assetNetwork(
                                placeholder: kPostImagePlaceholder,
                                image: item,
                                fit: BoxFit.cover,
                                width:  MediaQuery.of(context).size.width,
                              ),
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                        height:  MediaQuery.of(context).size.height * .5,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: false,
                        autoPlay: false,
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 900),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),
            saySomething(context: context),
          ],
        ),
      ),
    );
  }

  saySomething({required context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        LikeButton(
          circleColor:
              const CircleColor(start: Colors.yellow, end: Colors.cyan),
          bubblesColor: BubblesColor(
            dotPrimaryColor: Theme.of(context).primaryColor,
            dotSecondaryColor: Colors.red,
          ),
          likeBuilder: (isLiked) => Icon(
            announcementVotes.isEmpty ? Iconsax.heart : Iconsax.lovely,
            color: isLiked ? Colors.red : Colors.grey,
          ),
          likeCountPadding: EdgeInsets.only(left: 2.5.w),
          likeCount: announcementVotes.length,
          countBuilder: (count, isLiked, text) {
            final color = isLiked ? Colors.red : Colors.grey;
            return Text(
              text,
              style: TextStyle(
                color: color,
              ),
            );
          },
          isLiked: announcementVotes.contains(currentUserId),
          onTap: (isLiked) async {
            isLiked
                ? await removeVote(
                    collection: 'announcements',
                    docName: 'masteral-feed',
                    subCollection: 'post',
                    topicDocId: postDocId,
                    currentUid: [currentUserId],
                  )
                : await addVote(
                    collection: 'announcements',
                    docName: 'masteral-feed',
                    subCollection: 'post',
                    topicDocId: postDocId,
                    currentUid: [currentUserId],
                  );
            return !isLiked;
          },
        ),
        Align(
          alignment: Alignment.center,
          child: TextButton.icon(
            onPressed: () {
              Get.to(
                () => ShowAllComment(
                  postDocId: postDocId,
                  collectionName: 'announcements',
                  docName: 'masteral-feed',
                  profileName: accountName,
                  profileImageUrl: accountProfileImageUrl,
                  postDescription: postCaption,
                ),
              );
            },
            icon: const Icon(Iconsax.message_add),
            label: const Text(
              'Say something...',
              style: TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }

  FocusedMenuHolder meneHolder(BuildContext context) {
    return FocusedMenuHolder(
      menuWidth:  MediaQuery.of(context).size.width * 0.50,
      blurSize: 1.0,
      menuItemExtent: 5.h,
      menuBoxDecoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(1.w))),
      duration: const Duration(milliseconds: 100),
      animateMenuItems: false,
      blurBackgroundColor: Colors.black,
      openWithTap: true,
      menuOffset: 1.h,
      onPressed: () {},
      menuItems: accountType == 'accountTypeMasteralAdmin'
          ?
          //menu item for campus and registrar admin
          [
              focusMenuItem(
                'Details',
                Iconsax.firstline,
                Colors.black54,
                () {
                  Get.to(
                    () => PostDetails(
                      postMedia: postMedia,
                      postCaption: postCaption,
                    ),
                  );
                },
              ),
              focusMenuItem(
                'Edit Caption',
                Iconsax.edit,
                Colors.black54,
                () {
                  Get.to(
                    () => EditCaption(
                      docName: announcementTypeDoc,
                      postDocId: postDocId,
                      recentCaption: postCaption,
                    ),
                  );
                },
              ),
              focusMenuItem(
                'Delete',
                Iconsax.trash,
                Colors.red,
                () {
                  //dialog for deletion of post
                  dialogs.deletePostDialog(
                    context,
                    'assets/gifs/question_mark.gif',
                    'Delete Post 🗑',
                    'Are you sure? your about to delete this post? 🤔',
                    announcementTypeDoc,
                    postDocId,
                    postMedia,
                  );
                },
              ),
            ]
          :
          //menu item for professors and students
          [
              focusMenuItem(
                'Details',
                Iconsax.firstline,
                Colors.black54,
                () {
                  Get.to(
                    () => PostDetails(
                      postMedia: postMedia,
                      postCaption: postCaption,
                    ),
                  );
                },
              ),
              focusMenuItem(
                'Report',
                Iconsax.warning_2,
                Colors.red,
                () {
                  dialogs.reportPostDialog(
                    context: context,
                    reportType: 'masteral-feed',
                    reportDocumentId: postDocId,
                  );
                },
              ),
            ],
      child: const Icon(
        Iconsax.more,
      ),
    );
  }
}
