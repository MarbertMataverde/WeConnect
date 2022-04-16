import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../../../widgets/appbar/build_appbar.dart';
import '../../../../widgets/global%20spinkit/global_spinkit.dart';
import '../../../phone%20view/home/channel%20box/channel_inside.dart';
import '../../../phone%20view/home/channel%20box/channel_join.dart';
import '../../../../controller/controller_account_information.dart';
import '../../../../controller/controller_post_tile_pop_up_menu.dart';
import '../../../../dialog/dialog_channel.dart';

import '../../../../controller/controller_channel.dart';
import '../../../../widgets/navigation drawer/widget_navigation_drawer.dart';
import 'channel_new.dart';

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
      appBar: buildAppBar(
        context: context,
        title: 'Channels',
        actions: [
          Visibility(
            visible: currentAccountType == 'accountTypeProfessor',
            child: IconButton(
              tooltip: 'New Channel🔥',
              onPressed: () {
                Get.to(() => const ChannelNew());
              },
              icon: Icon(
                Iconsax.message_add,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ),
          Visibility(
            visible: currentAccountType == 'accountTypeStudent',
            child: IconButton(
              tooltip: 'Join Channel🔥',
              onPressed: () {
                Get.to(() => const ChannelJoin());
              },
              icon: Icon(
                Iconsax.message_add,
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
      body: StreamBuilder<QuerySnapshot>(
        stream: currentAccountType == 'accountTypeProfessor'
            ? _professorStream
            : _studentStream,
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
              return buildChannelTile(
                context: context,
                channelAvatarImage: data.docs[index]['channel-avatar-image'],
                channelAdminName: data.docs[index]['channel-admin-name'],
                channelName: data.docs[index]['channel-name'],
                onCliked: () {
                  Get.to(() => ChannelInside(
                        channelName: data.docs[index]['channel-name'],
                        token: data.docs[index].id,
                        channelAvatarImage: data.docs[index]
                            ['channel-avatar-image'],
                        channelDocId: data.docs[index].id,
                      ));
                },
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
  required BuildContext context,
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
        radius: 10.w,
        backgroundImage: NetworkImage(
          channelAvatarImage,
        ),
      ),
      title: Text(
        channelName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyMedium!.color,
        ),
      ),
      subtitle: Text(
        channelAdminName,
        style: TextStyle(
          color: Theme.of(context).textTheme.labelMedium!.color,
        ),
      ),
      trailing: Visibility(
        visible: currentAccountType.toString() == 'accountTypeProfessor',
        child: FocusedMenuHolder(
          menuWidth: MediaQuery.of(context).size.width * 0.50,
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
              Iconsax.trash,
              Colors.red,
              () => channelDialog.deleteChannelDialog(
                context,
                assetLocation: 'assets/gifs/question_mark.gif',
                title: 'Channel Delition 🗑',
                description:
                    'Yor\'re about to delete this channel\nare you sure about that?',
                channelDocId: channelDocId,
                channelAvatarImage: channelAvatarImage,
              ),
            )
          ],
          child: Icon(Iconsax.more_square,
              color: Theme.of(context).iconTheme.color),
        ),
      ),
    ),
  );
}
