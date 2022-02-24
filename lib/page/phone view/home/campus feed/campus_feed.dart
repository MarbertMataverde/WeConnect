import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weconnect/page/phone%20view/forgot%20password/forgot_password.dart';

import '../../../../constant/constant_colors.dart';
import '../../../../widgets/announcement post tile/announcement_post_tile.dart';
import '../../../../widgets/appbar title/appbar_title.dart';
import '../upload/upload_post.dart';

final Stream<QuerySnapshot> campusFeedSnapshot = FirebaseFirestore.instance
    .collection('announcements')
    .doc('campus-feed')
    .collection('post')
    .orderBy('post-created-at', descending: true)
    .snapshots();

final box = GetStorage();

class CampusFeed extends StatefulWidget {
  const CampusFeed({Key? key}) : super(key: key);

  @override
  State<CampusFeed> createState() => _CampusFeedState();
}

class _CampusFeedState extends State<CampusFeed> {
  String? accountType;
  @override
  void initState() {
    accountTypeGetter();
    super.initState();
  }

  Future accountTypeGetter() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      accountType = sharedPreferences.get('accountType') as String;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              authentication.signOut();
            },
            icon: Icon(
              MdiIcons.bellOutline,
              color: Get.isDarkMode
                  ? kButtonColorDarkTheme
                  : kButtonColorLightTheme,
            )),
        centerTitle: true,
        title: const AppBarTitle(
          title: 'Campus Feed',
        ),
        actions: [
          Visibility(
            visible: accountType == 'accountTypeCampusAdmin' ||
                accountType == 'accountTypeCampusAdmin',
            child: IconButton(
              onPressed: () {
                Get.to(
                  () => const UploadFeedPost(
                    collectionName: 'announcements',
                    docName: 'campus-feed',
                  ),
                );
              },
              icon: Icon(
                MdiIcons.cardPlusOutline,
                color: Get.isDarkMode
                    ? kButtonColorDarkTheme
                    : kButtonColorLightTheme,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              MdiIcons.menu,
              color: Get.isDarkMode
                  ? kButtonColorDarkTheme
                  : kButtonColorLightTheme,
            ),
          ),
        ],
      ),
      extendBody: true,
      body: StreamBuilder<QuerySnapshot>(
        stream: campusFeedSnapshot,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              return AnnouncementPostTile(
                postCreatedAt: data.docs[index]['post-created-at'],
                accountName: data.docs[index]['account-name'],
                postDescription: data.docs[index]['post-description'],
                accountProfileImageUrl: data.docs[index]
                    ['account-profile-image-url'],
                postMedia: _imageList,
                //delition data
                announcementTypeDoc: 'campus-feed',
                postDocId: data.docs[index].id,
                media: _imageList,
              );
            },
          );
        },
      ),
    );
  }
}
