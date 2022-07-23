import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weconnect/widgets/appbar/build_appbar.dart';

import '../announcement post tile/campus_announcement_post_tile.dart';
import '../global spinkit/global_spinkit.dart';

class AccountTypePostList extends StatelessWidget {
  const AccountTypePostList({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> campusFeedSnapshot = FirebaseFirestore.instance
        .collection('announcements')
        .doc('campus-feed')
        .collection('post')
        .where('account-name', isEqualTo: name)
        .orderBy('post-created-at', descending: true)
        .snapshots();
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: name,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Iconsax.arrow_square_left,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: campusFeedSnapshot,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              return CampusAnnouncementPostTile(
                postCreatedAt: data.docs[index]['post-created-at'],
                accountName: data.docs[index]['account-name'],
                postCaption: data.docs[index]['post-caption'],
                accountProfileImageUrl: data.docs[index]
                    ['account-profile-image-url'],
                postMedia: imageList,
                //delition data
                announcementTypeDoc: 'campus-feed',
                postDocId: data.docs[index].id,
                media: imageList,
                //account type
                accountType: data.docs[index]['account-type'],
                //announcement list of votes
                announcementVotes: data.docs[index]['votes'],
              );
            },
          );
        },
      ),
    );
  }
}
