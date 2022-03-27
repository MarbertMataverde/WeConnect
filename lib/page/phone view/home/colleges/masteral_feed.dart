import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../widgets/appbar/build_appbar.dart';
import '../../../../controller/controller_account_information.dart';

import '../../../../widgets/announcement post tile/masteral_announcement_post_tile.dart';
import '../../../../widgets/global spinkit/global_spinkit.dart';
import '../../../../widgets/navigation drawer/widget_navigation_drawer.dart';
import '../upload post/upload_post.dart';

final Stream<QuerySnapshot> masteralFeedSnapshot = FirebaseFirestore.instance
    .collection('announcements')
    .doc('masteral-feed')
    .collection('post')
    .orderBy('post-created-at', descending: true)
    .snapshots();

class MasteralFeed extends StatefulWidget {
  const MasteralFeed({Key? key}) : super(key: key);

  @override
  State<MasteralFeed> createState() => _MasteralFeedState();
}

class _MasteralFeedState extends State<MasteralFeed> {
  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: const WidgetNavigationDrawer(),
        appBar: buildAppBar(
          context: context,
          title: 'Masteral Feed',
          leading: Visibility(
            visible: !(currentAccountType == 'accountTypeMasteralAdmin' ||
                currentStudentCollege == 'Masteral'),
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Iconsax.arrow_square_left,
                  color: Theme.of(context).iconTheme.color,
                )),
          ),
          actions: [
            Visibility(
              visible: currentAccountType == 'accountTypeMasteralAdmin',
              child: IconButton(
                onPressed: () {
                  Get.to(
                    () => const UploadFeedPost(
                      collectionName: 'announcements',
                      docName: 'masteral-feed',
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
          stream: masteralFeedSnapshot,
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
                List _imageList = data.docs[index]['post-media'];
                return MasteralAnnouncementPostTile(
                  postCreatedAt: data.docs[index]['post-created-at'],
                  accountName: data.docs[index]['account-name'],
                  postCaption: data.docs[index]['post-caption'],
                  accountProfileImageUrl: data.docs[index]
                      ['account-profile-image-url'],
                  postMedia: _imageList,
                  //delition data
                  announcementTypeDoc: 'masteral-feed',
                  postDocId: data.docs[index].id,
                  media: _imageList,
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
