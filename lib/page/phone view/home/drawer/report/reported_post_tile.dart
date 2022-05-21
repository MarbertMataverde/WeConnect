import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../constant/constant.dart';
import '../../../../../constant/constant_colors.dart';
import '../../../../../controller/controller_post_tile_pop_up_menu.dart';
import '../../../../../controller/controller_report.dart';
import '../../../../../dialog/dialog_post_tile_.dart';
import '../../edit post caption/edit_caption.dart';
import '../../post details/post_details.dart';

DateFormat dateFormat = DateFormat("MMM-dd");

//account type
final box = GetStorage();

//pop up based on account type

//dialogs
final dialogs = Get.put(DialogPostTile());

//report
final report = Get.put(ControllerReport());

class ReportedPostTile extends StatelessWidget {
  const ReportedPostTile({
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
    required this.reportDocId,
  }) : super(key: key);
  //dismissal or deletion of the report details
  final String reportDocId;
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

  //editign caption
  //announcement type doc name
  // same as announcementTypeDoc
  //
  //announcement doc id
  //same as postDocId
  //
  //recent description
  //same as postDescriotion

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                            color:
                                Theme.of(context).textTheme.labelMedium!.color,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                FocusedMenuHolder(
                  menuWidth: Get.mediaQuery.size.width * 0.50,
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
                  child: const Icon(
                    Iconsax.more,
                  ),
                  onPressed: () {},
                  menuItems: [
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
                      'Delete Post',
                      Iconsax.trash,
                      Colors.red,
                      () async {
                        await dialogs.deletePostDialog(
                          context,
                          'assets/gifs/question_mark.gif',
                          'Post Deletion',
                          'You cannot undo this action, press ok to continue.',
                          announcementTypeDoc,
                          postDocId,
                          postMedia,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpandableText(
              postCaption,
              maxLines: 3,
              expandText: 'more',
              expandOnTextTap: true,
              collapseOnTextTap: true,
              collapseText: 'collapse',
              animation: true,
              animationCurve: Curves.fastLinearToSlowEaseIn,
            ),
          ),
          postMedia.length == 1
              ? GestureDetector(
                  onTap: () => Get.to(() => PostDetails(
                        postMedia: postMedia,
                        postCaption: postCaption,
                      )),
                  child: Image.network(postMedia.first),
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
                            child: Image.network(
                              item,
                              fit: BoxFit.cover,
                              width: Get.mediaQuery.size.width,
                            ),
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      height: Get.mediaQuery.size.height * .5,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 900),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
