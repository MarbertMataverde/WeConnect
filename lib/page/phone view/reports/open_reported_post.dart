import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:weconnect/widgets/reported%20post%20tile/announcement_post_tile.dart';

import '../../../constant/constant_colors.dart';
import '../../../widgets/appbar title/appbar_title.dart';

class OpenReportedPost extends StatelessWidget {
  const OpenReportedPost({Key? key, required this.data}) : super(key: key);
  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    final reportedPost = FirebaseFirestore.instance
        .collection('announcements')
        .doc(data['report-type'])
        .collection('post')
        .doc(data['post-documment-id'])
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
          title: 'Reported Post',
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: reportedPost,
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
            List _imageList = snapshotData['post-media'];
            return ReportedPostTile(
              postCreatedAt: snapshotData['post-created-at'],
              accountName: snapshotData['account-name'],
              postCaption: snapshotData['post-caption'],
              accountProfileImageUrl: snapshotData['account-profile-image-url'],
              postMedia: _imageList,
              //delition data
              announcementTypeDoc: 'campus-feed',
              postDocId: data['post-documment-id'],
              media: _imageList,
              //edit caption
            );
          }

          return const Text("loading");
        },
      ),
    );
  }
}
