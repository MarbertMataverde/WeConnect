import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/widgets/appbar/build_appbar.dart';

import '../../../../../controller/controller_report.dart';
import 'reported_post_tile.dart';

//report
final report = Get.put(ControllerReport());

class DetailedReport extends StatelessWidget {
  const DetailedReport({
    Key? key,
    required this.reportType,
    required this.postDocId,
    required this.reporterProfileImageUrl,
    required this.reportedConcern,
    required this.reportedConcernDescription,
    required this.reporterName,
    required this.reportedAt,
    required this.reportDocId,
  }) : super(key: key);
  //reported post tile
  final String reportType;
  final String postDocId;
  //report concerns
  final Timestamp reportedAt;
  final String reporterName;
  final String reporterProfileImageUrl;
  final String reportedConcern;
  final String reportedConcernDescription;

  //report doc id this is used for dismissal or deletion of the report
  final String reportDocId;
  @override
  Widget build(BuildContext context) {
    final reportedPost = FirebaseFirestore.instance
        .collection('announcements')
        .doc(reportType)
        .collection('post')
        .doc(postDocId)
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
              await report.dismissReport(
                context: context,
                title: 'Report Dismissal',
                assetLocation: 'assets/gifs/dismiss_report.gif',
                description: 'Are you sure you want to dissmiss this issue?',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<DocumentSnapshot>(
                future: reportedPost,
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Something went wrong");
                  }

                  if (snapshot.hasData && !snapshot.data!.exists) {
                    return const Text("Document does not exist");
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> snapshotData =
                        snapshot.data!.data() as Map<String, dynamic>;
                    List _imageList = snapshotData['post-media'];
                    return ReportedPostTile(
                      postCreatedAt: snapshotData['post-created-at'],
                      accountName: snapshotData['account-name'],
                      postCaption: snapshotData['post-caption'],
                      accountProfileImageUrl:
                          snapshotData['account-profile-image-url'],
                      postMedia: _imageList,
                      //delition data
                      announcementTypeDoc: reportType,
                      postDocId: postDocId,
                      media: _imageList,
                      //edit caption
                    );
                  }

                  return const Text("loading");
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                    Padding(
                      padding: EdgeInsets.only(left: 5.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reportedConcern.toUpperCase(),
                            textScaleFactor: 1,
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            reportedConcernDescription,
                            textScaleFactor: 0.9,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
