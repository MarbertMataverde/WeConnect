import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/widgets/global%20spinkit/global_spinkit.dart';
import '../../../../../constant/constant.dart';
import '../../../../../widgets/appbar/build_appbar.dart';

import '../../../../../controller/controller_report.dart';

//report
final report = Get.put(ControllerReport());

class ForumTopicDetailedReport extends StatelessWidget {
  const ForumTopicDetailedReport({
    Key? key,
    required this.topicDocId,
    required this.reporterProfileImageUrl,
    required this.reporterName,
    required this.reportedConcern,
    required this.reportedConcernDescription,
    required this.reportDocId,
  }) : super(key: key);
  //this is the actual topic
  final String topicDocId;
  //this is the concern of the topic
  final String reporterProfileImageUrl;
  final String reporterName;
  final String reportedConcern;
  final String reportedConcernDescription;
  // this is for dimissal of the report
  final String reportDocId;
  @override
  Widget build(BuildContext context) {
    final reportedForumTopic = FirebaseFirestore.instance
        .collection('forum')
        .doc('approved-request')
        .collection('all-approved-request')
        .doc(topicDocId)
        .get();

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
              report.dismissReport(
                context: context,
                title: 'Report Dismissal',
                assetLocation: 'assets/gifs/dismiss_report.gif',
                description: 'Are you sure you want to dissmiss this issue?',
                reportDocType: 'forum-topic-report',
                reportDocId: reportDocId,
              );
            },
            icon: const Icon(
              Iconsax.close_square,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: reportedForumTopic,
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> snapshotData =
                snapshot.data!.data() as Map<String, dynamic>;

            return SingleChildScrollView(
              child: Column(
                children: [
                  reportedTopicTile(context, snapshotData),
                  const Divider(),
                  topicReportConcern(context),
                ],
              ),
            );
          }

          return buildGlobalSpinkit(context: context);
        },
      ),
    );
  }

  Padding topicReportConcern(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5.w),
                child: Image.network(
                  reporterProfileImageUrl,
                  height: MediaQuery.of(context).size.width * 0.1,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
              Text(
                reporterName,
                textScaleFactor: 1.1,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                reportedConcern.toUpperCase(),
                textScaleFactor: 1,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                reportedConcernDescription,
                textScaleFactor: 0.9,
                style: TextStyle(
                  color: Theme.of(context).textTheme.labelMedium!.color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget reportedTopicTile(
      BuildContext context, Map<String, dynamic> snapshotData) {
    return Padding(
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
                    image: snapshotData['requester-profile-image-url'],
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
                    snapshotData['requested-by'],
                    textScaleFactor: 1.2,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                  ),
                  Text(
                    DateFormat('d MMM yyyy').format(
                      snapshotData['request-accepted-at'].toDate(),
                    ),
                    textScaleFactor: 0.8,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.labelMedium!.color,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Icon(
                Iconsax.heart,
                color: snapshotData['votes'].length == 0
                    ? Colors.grey
                    : Colors.red,
              ),
              SizedBox(
                width: 1.w,
              ),
              Text(
                snapshotData['votes'].length.toString(),
                style: TextStyle(
                  color: snapshotData['votes'].length == 0
                      ? Colors.grey
                      : Colors.red,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Text(
            snapshotData['topic-title'],
            textScaleFactor: 1.3,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          ExpandableText(
            snapshotData['topic-description'],
            expandText: 'read more',
            maxLines: 12,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
            linkStyle: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
