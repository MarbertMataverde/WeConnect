import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/page/phone%20view/home/report/reported_post_tile.dart';

import '../../../../constant/constant_colors.dart';
import '../../../../widgets/appbar title/appbar_title.dart';

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
  @override
  Widget build(BuildContext context) {
    final reportedPost = FirebaseFirestore.instance
        .collection('announcements')
        .doc(reportType)
        .collection('post')
        .doc(postDocId)
        .get();

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
          title: 'Detailed Report',
        ),
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
              Divider(
                indent: 10.w,
                endIndent: 10.w,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(reporterProfileImageUrl),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            reporterName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 12.w),
                        child: Text(
                          reportedConcern,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                      Text(
                        reportedConcernDescription,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
