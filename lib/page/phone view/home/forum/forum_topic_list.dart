import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/page/phone%20view/home/forum/open_new_topic.dart';

import '../../../../constant/constant_colors.dart';
import '../../../../controller/controller_post_tile_pop_up_menu.dart';
import '../../../../widgets/appbar title/appbar_title.dart';
import '../../../../widgets/navigation drawer/widget_navigation_drawer.dart';

class Forum extends StatefulWidget {
  const Forum({
    Key? key,
  }) : super(key: key);

  @override
  State<Forum> createState() => _ForumState();
}

class _ForumState extends State<Forum> {
  final Stream<QuerySnapshot> _forumTopicStream = FirebaseFirestore.instance
      .collection('forum')
      .doc('approved-request')
      .collection('all-approved-request')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const WidgetNavigationDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: const AppBarTitle(
          title: 'Campus Forum',
        ),
        actions: [
          IconButton(
            tooltip: 'Open New Topic🔥',
            onPressed: () {
              Get.to(() => const OpenNewTopic());
            },
            icon: Icon(
              MdiIcons.textBoxPlusOutline,
              color: Get.isDarkMode
                  ? kButtonColorDarkTheme
                  : kButtonColorLightTheme,
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
      body: StreamBuilder<QuerySnapshot>(
        stream: _forumTopicStream,
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
              return buildChannelTile(
                topicOwnerName: data.docs[index]['requested-by'],
                topicTitle: data.docs[index]['topic-title'],
                topicVotes: data.docs[index]['votes'],
                topicAcceptedDate: data.docs[index]['request-accepted-at'],
                channelDocId: data.docs[index].id,
                onCliked: () {},
              );
            },
          );
        },
      ),
    );
  }
}

Widget buildChannelTile({
  required String topicOwnerName,
  required String topicTitle,
  required int topicVotes,
  required Timestamp topicAcceptedDate,
  VoidCallback? onCliked,
  //deleting channel
  required String channelDocId,
}) {
  return ListTile(
    enableFeedback: true,
    onTap: onCliked,
    contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
    title: Text(
      topicTitle,
      textScaleFactor: 1.1,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: Get.theme.primaryColor),
    ),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          topicOwnerName,
          textScaleFactor: 0.9,
          style: const TextStyle(height: 0.8),
        ),
        SizedBox(
          height: 1.h,
        ),
        Row(
          children: [
            Text('54 Comments 💬'),
            SizedBox(
              width: 3.w,
            ),
            Text('$topicVotes Votes ❤'),
            const Spacer(),
            Text(
              DateFormat('d MMM yyyy').format(
                topicAcceptedDate.toDate(),
              ),
            ),
          ],
        ),
      ],
    ),
    textColor: Get.isDarkMode ? kTextColorDarkTheme : kTextColorLightTheme,
  );
}
