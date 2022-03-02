import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constant/constant_colors.dart';
import '../../../../widgets/announcement post tile/campus_announcement_post_tile.dart';
import '../../../../widgets/appbar title/appbar_title.dart';
import '../../../../widgets/navigation drawer/widget_navigation_drawer.dart';
import '../upload post/upload_post.dart';

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
  String? studentCollege;
  @override
  void initState() {
    accountTypeGetter();
    super.initState();
  }

  Future accountTypeGetter() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      accountType = sharedPreferences.get('accountType').toString();
      studentCollege = sharedPreferences.get('studentCollege').toString();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: WidgetNavigationDrawer(
          accountType: accountType.toString(),
          studentCollege: studentCollege.toString(),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {},
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
                  accountType == 'accountTypeRegistrarAdmin',
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
            Builder(
              builder: ((context) {
                return IconButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  icon: Icon(
                    MdiIcons.menu,
                    color: Get.isDarkMode
                        ? kButtonColorDarkTheme
                        : kButtonColorLightTheme,
                  ),
                );
              }),
            ),
          ],
        ),
        extendBody: true,
        body: StreamBuilder<QuerySnapshot>(
          stream: campusFeedSnapshot,
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
                return CampusAnnouncementPostTile(
                  postCreatedAt: data.docs[index]['post-created-at'],
                  accountName: data.docs[index]['account-name'],
                  postCaption: data.docs[index]['post-caption'],
                  accountProfileImageUrl: data.docs[index]
                      ['account-profile-image-url'],
                  postMedia: _imageList,
                  //delition data
                  announcementTypeDoc: 'campus-feed',
                  postDocId: data.docs[index].id,
                  media: _imageList,
                  //account type
                  accountType: accountType.toString(),
                );
              },
            );
          },
        ),
      );
}
