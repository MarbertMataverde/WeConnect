import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../../constant/constant_colors.dart';
import '../../../../../dialog/dialog_forum.dart';
import '../../../../../widgets/appbar title/appbar_title.dart';

final DialogForum forum = Get.put(DialogForum());

class RequestDetails extends StatelessWidget {
  const RequestDetails({
    Key? key,
    required this.requesterProfileImageUrl,
    required this.requestedBy,
    required this.topicTitle,
    required this.topicDescription,
    required this.requestedAt,
    required this.requestDocId,
    required this.requesterUid,
  }) : super(key: key);

  final String requesterProfileImageUrl;
  final String requestedBy;
  final String topicTitle;
  final String topicDescription;
  final String requesterUid;
  final Timestamp requestedAt;

  //request dismissal
  final String requestDocId;
  @override
  Widget build(BuildContext context) {
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
            title: 'Request Details',
          ),
          actions: [
            IconButton(
              tooltip: 'Dismiss Request❌',
              onPressed: () async {
                await forum.dismissRequestDialog(
                  context,
                  assetLocation: 'assets/gifs/question_mark.gif',
                  title: 'Request Dismissal',
                  description: 'Are you sure about dismissing this request?',
                  requestDocId: requestDocId,
                );
              },
              icon: const Icon(
                Icons.remove_circle_outline,
                color: Colors.red,
              ),
            ),
            IconButton(
              tooltip: 'Publish Request🔥',
              onPressed: () async {
                await forum.requestApprovalDialog(context,
                    assetLocation: 'assets/gifs/question_mark.gif',
                    title: 'Request Approval',
                    description:
                        'Are you sure about approving this topic request?',
                    requestedBy: requestedBy,
                    requesterProfileImageUrl: requesterProfileImageUrl,
                    requesterUid: requesterUid,
                    topicTitle: topicTitle,
                    topicDescription: topicDescription,
                    requestDocId: requestDocId);
              },
              icon: Icon(
                MdiIcons.publish,
                color: Get.theme.primaryColor,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(3.h),
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
                          timeago.format(requestedAt.toDate()),
                          textScaleFactor: 0.7,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Get.isDarkMode
                                ? kTextColorDarkTheme
                                : kTextColorLightTheme,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  topicTitle,
                  textScaleFactor: 1.3,
                  style: TextStyle(
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
