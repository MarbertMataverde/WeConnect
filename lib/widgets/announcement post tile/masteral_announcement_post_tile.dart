import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/constant/constant_colors.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:weconnect/controller/controller_post_tile_pop_up_menu.dart';
import 'package:weconnect/dialog/dialog_post_tile_.dart';

import '../../page/phone view/home/edit post caption/edit_caption.dart';
import '../../page/phone view/home/post details/post_details.dart';
import '../post comment (Write and Show)/comment_write_show.dart';

DateFormat dateFormat = DateFormat("MMM-dd");

//account type
final box = GetStorage();

//pop up based on account type

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
      elevation: 3,
      color: Get.isDarkMode ? kTextFormFieldColorDarkTheme : Colors.white,
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
                    CircleAvatar(
                      radius: 14.sp,
                      backgroundImage: NetworkImage(accountProfileImageUrl),
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
                            color: Get.isDarkMode
                                ? kTextColorDarkTheme
                                : kTextColorLightTheme,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        //when post created with time ago format
                        Text(
                          timeago.format(postCreatedAt.toDate()),
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: Get.isDarkMode
                                ? kTextColorDarkTheme
                                : kTextColorLightTheme,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                FocusedMenuHolder(
                  menuWidth: MediaQuery.of(context).size.width * 0.50,
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
                            MdiIcons.details,
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
                            MdiIcons.pencil,
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
                            Icons.delete_outlined,
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
                            MdiIcons.details,
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
                            Icons.report_outlined,
                            Colors.red,
                            () {},
                          ),
                        ],
                  child: Icon(
                    Icons.more_vert_rounded,
                    color: Get.isDarkMode
                        ? kTextColorDarkTheme
                        : kTextColorLightTheme,
                    size: 13.sp,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpandableText(
              postCaption,
              style: TextStyle(
                color:
                    Get.isDarkMode ? kTextColorDarkTheme : kTextColorLightTheme,
              ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {},
                child: Align(
                  alignment: Alignment.center,
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      primary: Get.isDarkMode
                          ? kTextColorDarkTheme
                          : kTextColorLightTheme,
                    ),
                    onPressed: () {
                      Get.to(
                        () => ShowAllComment(
                          postDocId: postDocId,
                          collectionName: 'announcements',
                          docName: 'campus-feed',
                        ),
                      );
                    },
                    icon: const Icon(Icons.message),
                    label: Text(
                      'Write and show comments',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
