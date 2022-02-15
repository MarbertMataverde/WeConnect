import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constant/constant_colors.dart';
import '../../../widgets/announcement post tile/announcement_post_tile.dart';

final Stream<QuerySnapshot> campusFeedSnapshot = FirebaseFirestore.instance
    .collection('announcements')
    .doc('campus-feed')
    .collection('post')
    .snapshots();

class CampusFeed extends StatelessWidget {
  const CampusFeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: StreamBuilder<QuerySnapshot>(
        stream: campusFeedSnapshot,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
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
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Get.isDarkMode
            ? kTextFormFieldColorDarkTheme
            : kTextFormFieldColorLightTheme,
        mini: true,
        onPressed: () async {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();

          log(sharedPreferences.get('accountType').toString());
        },
        child: Icon(
          MdiIcons.textBoxPlusOutline,
          color:
              Get.isDarkMode ? kButtonColorDarkTheme : kButtonColorLightTheme,
        ),
      ),
    );
  }
}
