import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:weconnect/page/phone%20view/reports/open_reported_post.dart';
import 'package:weconnect/widgets/announcement%20post%20tile/announcement_post_tile.dart';

import '../../../constant/constant_colors.dart';
import '../../../widgets/appbar title/appbar_title.dart';

class ReportDetails extends StatelessWidget {
  const ReportDetails({Key? key, required this.data}) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
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
          title: 'Report Details',
        ),
        actions: [
          IconButton(
            tooltip: 'Open Reported Post',
            onPressed: () {
              Get.to(() => OpenReportedPost(data: data));
            },
            icon: Icon(
              Icons.open_in_new,
              color: Get.isDarkMode
                  ? kButtonColorDarkTheme
                  : kButtonColorLightTheme,
            ),
          ),
          IconButton(
            tooltip: 'Dismiss Report',
            onPressed: () {},
            icon: Icon(
              MdiIcons.trashCanOutline,
              color: Get.isDarkMode
                  ? kButtonColorDarkTheme
                  : kButtonColorLightTheme,
            ),
          ),
        ],
      ),
      body: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(data['reporter-profile-image-url']),
        ),
        title: Text(
          data['reporter-name'],
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          data['report-description'],
        ),
      ),
    );
  }
}
