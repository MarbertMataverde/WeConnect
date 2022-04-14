import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../../widgets/appbar/build_appbar.dart';

import '../../../../../dialog/dialog_forum.dart';

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
        appBar: buildAppBar(
          context: context,
          title: 'Details',
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Iconsax.arrow_square_left,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          actions: [
            IconButton(
              tooltip: 'Dismiss',
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
                Iconsax.close_square,
                color: Colors.red,
              ),
            ),
            IconButton(
              tooltip: 'Approve',
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
                Iconsax.tick_square,
                color: Theme.of(context).primaryColor,
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.w),
                      child: Image.network(
                        requesterProfileImageUrl,
                        height: MediaQuery.of(context).size.width * 0.2,
                        fit: BoxFit.cover,
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
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          timeago.format(requestedAt.toDate()),
                          textScaleFactor: 0.9,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color:
                                Theme.of(context).textTheme.labelMedium!.color,
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
                  topicTitle.toUpperCase(),
                  textScaleFactor: 1.2,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  topicDescription,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.labelMedium!.color,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
