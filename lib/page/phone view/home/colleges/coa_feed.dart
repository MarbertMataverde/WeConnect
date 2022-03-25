import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weconnect/widgets/appbar/build_appbar.dart';

import '../../../../controller/controller_account_information.dart';
import '../../../../widgets/announcement post tile/coa_announcement_post_tile.dart';
import '../../../../widgets/navigation drawer/widget_navigation_drawer.dart';
import '../upload post/upload_post.dart';

final Stream<QuerySnapshot> coaFeedSnapshot = FirebaseFirestore.instance
    .collection('announcements')
    .doc('coa-feed')
    .collection('post')
    .orderBy('post-created-at', descending: true)
    .snapshots();

class CoaFeed extends StatefulWidget {
  const CoaFeed({Key? key}) : super(key: key);

  @override
  State<CoaFeed> createState() => _CoaFeedState();
}

class _CoaFeedState extends State<CoaFeed> {
  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: const WidgetNavigationDrawer(),
        appBar: buildAppBar(
          context: context,
          title: 'COA Feed',
          leading: Visibility(
            visible: !(currentAccountType == 'accountTypeCoaAdmin' ||
                currentStudentCollege == 'College of Accountancy'),
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Iconsax.arrow_left_1,
                  color: Theme.of(context).iconTheme.color,
                )),
          ),
          actions: [
            Visibility(
              visible: currentAccountType == 'accountTypeCoaAdmin',
              child: IconButton(
                onPressed: () {
                  Get.to(
                    () => const UploadFeedPost(
                      collectionName: 'announcements',
                      docName: 'coa-feed',
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
          stream: coaFeedSnapshot,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return SpinKitSpinningLines(color: Get.theme.primaryColor);
            }
            final data = snapshot.requireData;
            return ListView.builder(
              itemCount: data.size,
              itemBuilder: (context, index) {
                List _imageList = data.docs[index]['post-media'];
                return CoaAnnouncementPostTile(
                  postCreatedAt: data.docs[index]['post-created-at'],
                  accountName: data.docs[index]['account-name'],
                  postCaption: data.docs[index]['post-caption'],
                  accountProfileImageUrl: data.docs[index]
                      ['account-profile-image-url'],
                  postMedia: _imageList,
                  //delition data
                  announcementTypeDoc: 'coa-feed',
                  postDocId: data.docs[index].id,
                  media: _imageList,
                  //accountType
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
