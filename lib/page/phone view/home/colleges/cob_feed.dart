import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../widgets/appbar/build_appbar.dart';

import '../../../../controller/controller_account_information.dart';

import '../../../../widgets/announcement post tile/cob_announcement_post_tile.dart';
import '../../../../widgets/global spinkit/global_spinkit.dart';
import '../../../../widgets/navigation drawer/widget_navigation_drawer.dart';
import '../upload post/upload_post.dart';

final Stream<QuerySnapshot> cobFeedSnapshot = FirebaseFirestore.instance
    .collection('announcements')
    .doc('cob-feed')
    .collection('post')
    .orderBy('post-created-at', descending: true)
    .snapshots();

class CobFeed extends StatefulWidget {
  const CobFeed({Key? key}) : super(key: key);

  @override
  State<CobFeed> createState() => _CobFeedState();
}

class _CobFeedState extends State<CobFeed> {
  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: const WidgetNavigationDrawer(),
        appBar: buildAppBar(
          context: context,
          title: 'COB Feed',
          leading: !(currentAccountType == 'accountTypeCobAdmin' ||
                  currentStudentCollege == 'College of Business')
              ? IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Iconsax.arrow_square_left,
                    color: Theme.of(context).iconTheme.color,
                  ),
                )
              : null,
          actions: [
            Visibility(
              visible: currentAccountType == 'accountTypeCobAdmin',
              child: IconButton(
                onPressed: () {
                  Get.to(
                    () => const UploadFeedPost(
                      collectionName: 'announcements',
                      docName: 'cob-feed',
                    ),
                  );
                },
                icon: Icon(
                  Iconsax.add_square,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
            Builder(
              builder: ((context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: Icon(
                    Iconsax.menu,
                    color: Theme.of(context).iconTheme.color,
                  ),
                );
              }),
            ),
          ],
        ),
        extendBody: true,
        body: StreamBuilder<QuerySnapshot>(
          stream: cobFeedSnapshot,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return buildGlobalSpinkit(context: context);
            }
            final data = snapshot.requireData;
            return ListView.builder(
              itemCount: data.size,
              itemBuilder: (context, index) {
                List imageList = data.docs[index]['post-media'];
                return CobAnnouncementPostTile(
                  postCreatedAt: data.docs[index]['post-created-at'],
                  accountName: data.docs[index]['account-name'],
                  postCaption: data.docs[index]['post-caption'],
                  accountProfileImageUrl: data.docs[index]
                      ['account-profile-image-url'],
                  postMedia: imageList,
                  //delition data
                  announcementTypeDoc: 'cob-feed',
                  postDocId: data.docs[index].id,
                  media: imageList,
                  //account type
                  accountType: currentAccountType.toString(),
                  //announcement list of votes
                  announcementVotes: data.docs[index]['votes'],
                );
              },
            );
          },
        ),
      );
}
