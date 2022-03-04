import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/controller/controller_account_information.dart';
import 'package:weconnect/controller/controller_post_tile_pop_up_menu.dart';
import 'package:weconnect/dialog/dialog_channel.dart';

import '../../../../constant/constant_colors.dart';
import '../../../../controller/controller_channel.dart';
import '../../../../widgets/appbar title/appbar_title.dart';
import '../../../../widgets/navigation drawer/widget_navigation_drawer.dart';
import 'new_channel.dart';

final channel = Get.put(ControllerChannel());

final channelDialog = Get.put(DialogChannel());

class ChannelList extends StatefulWidget {
  const ChannelList({Key? key}) : super(key: key);

  @override
  State<ChannelList> createState() => _ChannelListState();
}

class _ChannelListState extends State<ChannelList> {
  //channel stream for professor or student
  final Stream<QuerySnapshot> _professorStream = FirebaseFirestore.instance
      .collection('channels')
      .where('professor-uid', isEqualTo: currentUserId)
      .snapshots();

  final Stream<QuerySnapshot> _studentStream = FirebaseFirestore.instance
      .collection('channels')
      .where('subscriber-list', arrayContains: currentUserId)
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
          title: 'Channel List',
        ),
        actions: [
          Visibility(
            visible: currentAccountType == 'accountTypeProfessor',
            child: IconButton(
              tooltip: 'New Channel Box',
              onPressed: () {
                Get.to(() => const NewChannel());
              },
              icon: Icon(
                MdiIcons.messagePlusOutline,
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
      body: StreamBuilder<QuerySnapshot>(
        stream: currentAccountType == 'accountTypeProfessor'
            ? _professorStream
            : _studentStream,
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
                channelAvatarImage: data.docs[index]['channel-avatar-image'],
                channelAdminName: data.docs[index]['channel-admin-name'],
                channelName: data.docs[index]['channel-name'],
                onCliked: () {},
                //deleting channel
                channelDocId: data.docs[index].id,
              );
            },
          );
        },
      ),
    );
  }
}

Widget buildChannelTile({
  required String channelAvatarImage, // used both for creating and deleting
  required String channelAdminName,
  required String channelName,
  VoidCallback? onCliked,
  //deleting channel
  required String channelDocId,
}) {
  return InkWell(
    onTap: onCliked,
    child: ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 3.w),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(channelAvatarImage),
      ),
      title: Text(
        channelName,
      ),
      subtitle: Text(channelAdminName),
      trailing: FocusedMenuHolder(
        menuWidth: Get.mediaQuery.size.width * 0.50,
        blurSize: 1.0,
        menuItemExtent: 5.h,
        menuBoxDecoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(1.w))),
        duration: const Duration(milliseconds: 100),
        animateMenuItems: false,
        blurBackgroundColor: Colors.black,
        openWithTap: true,
        menuOffset: 1.h,
        onPressed: () {},
        menuItems: [
          focusMenuItem(
            'Delete Channel',
            MdiIcons.deleteOutline,
            Colors.red,
            () => channelDialog.deleteChannelDialog(
              Get.context,
              assetLocation: 'assets/gifs/question_mark.gif',
              title: 'Channel Delition 🗑',
              description:
                  'Yor\'re about to delete this channel\nare you sure about that?',
              channelDocId: channelDocId,
              channelAvatarImage: channelAvatarImage,
            ),
          )
        ],
        child: Icon(
          MdiIcons.dotsVerticalCircleOutline,
          color:
              Get.isDarkMode ? kButtonColorDarkTheme : kButtonColorLightTheme,
        ),
      ),
    ),
  );
}
// channelDocId: data.docs[index].id,
