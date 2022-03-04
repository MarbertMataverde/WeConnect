import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constant/constant_colors.dart';
import '../../../../widgets/announcement post tile/cob_announcement_post_tile.dart';
import '../../../../widgets/appbar title/appbar_title.dart';
import '../../../../widgets/navigation drawer/widget_navigation_drawer.dart';
import '../upload post/upload_post.dart';

final Stream<QuerySnapshot> cobFeedSnapshot = FirebaseFirestore.instance
    .collection('announcements')
    .doc('cob-feed')
    .collection('post')
    .orderBy('post-created-at', descending: true)
    .snapshots();

final box = GetStorage();

class CobFeed extends StatefulWidget {
  const CobFeed({Key? key}) : super(key: key);

  @override
  State<CobFeed> createState() => _CobFeedState();
}

class _CobFeedState extends State<CobFeed> {
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
      accountType = sharedPreferences.get('accountType') as String;
      studentCollege = sharedPreferences.get('studentCollege').toString();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        endDrawer: const WidgetNavigationDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Visibility(
            visible: (accountType == 'accountTypeCampusAdmin' ||
                    accountType == 'accountTypeRegistrarAdmin' ||
                    accountType == 'accountTypeProfessor') ||
                studentCollege != 'College of Business',
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  MdiIcons.arrowLeft,
                  color: Get.isDarkMode
                      ? kButtonColorDarkTheme
                      : kButtonColorLightTheme,
                )),
          ),
          centerTitle: true,
          title: const AppBarTitle(
            title: 'COB Feed',
          ),
          actions: [
            Visibility(
              visible: accountType == 'accountTypeCobAdmin',
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
          stream: cobFeedSnapshot,
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
                return CobAnnouncementPostTile(
                  postCreatedAt: data.docs[index]['post-created-at'],
                  accountName: data.docs[index]['account-name'],
                  postCaption: data.docs[index]['post-caption'],
                  accountProfileImageUrl: data.docs[index]
                      ['account-profile-image-url'],
                  postMedia: _imageList,
                  //delition data
                  announcementTypeDoc: 'cob-feed',
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
