import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constant/constant_colors.dart';
import '../../../../controller/controller_new_channel.dart';
import '../../../../widgets/appbar title/appbar_title.dart';
import '../../../../widgets/navigation drawer/widget_navigation_drawer.dart';
import 'new_channel.dart';

final box = GetStorage();

final channel = Get.put(ControllerNewChannel());

class ChannelList extends StatefulWidget {
  const ChannelList({Key? key}) : super(key: key);

  @override
  State<ChannelList> createState() => _ChannelListState();
}

class _ChannelListState extends State<ChannelList> {
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

  //channel stream for professor or student
  final Stream<QuerySnapshot> _professorStream = FirebaseFirestore.instance
      .collection('channels')
      .where('professor-uid', isEqualTo: box.read('currentUid'))
      .snapshots();

  final Stream<QuerySnapshot> _studentStream = FirebaseFirestore.instance
      .collection('channels')
      .where('subscriber-list', arrayContains: box.read('currentUid'))
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: WidgetNavigationDrawer(
        accountType: accountType.toString(),
        studentCollege: studentCollege.toString(),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: const AppBarTitle(
          title: 'Channel List',
        ),
        actions: [
          Visibility(
            visible: accountType == 'accountTypeProfessor',
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
        stream: accountType == 'accountTypeProfessor'
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
              );
            },
          );
        },
      ),
    );
  }
}

Widget buildChannelTile({
  required String channelAvatarImage,
  required String channelAdminName,
  required String channelName,
  VoidCallback? onCliked,
}) {
  return InkWell(
    onTap: onCliked,
    child: ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(channelAvatarImage),
      ),
      title: Text(
        channelName,
      ),
      subtitle: Text(channelAdminName),
    ),
  );
}
// channelDocId: data.docs[index].id,
