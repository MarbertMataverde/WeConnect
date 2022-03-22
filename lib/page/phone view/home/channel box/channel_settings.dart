import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../../../widgets/appbar/appbar_back.dart';

import '../../../../constant/constant_colors.dart';
import '../../../../widgets/appbar/appbar_title.dart';

class ChannelSettings extends StatelessWidget {
  const ChannelSettings(
      {Key? key, required this.channelAvatarImage, required this.channelName})
      : super(key: key);

  final String channelAvatarImage;
  final String channelName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: buildAppbarBackButton(),
        centerTitle: true,
        title: const AppBarTitle(
          title: 'Settings',
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.delete_outline,
                color: Get.isDarkMode
                    ? kButtonColorDarkTheme
                    : kButtonColorLightTheme,
              ))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: Get.mediaQuery.size.width * 0.15,
            backgroundImage: NetworkImage(channelAvatarImage),
          ),
          SizedBox(
            height: Get.mediaQuery.size.height * 0.01,
          ),
          Text(
            channelName,
            textScaleFactor: 1.5,
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: ListView(
              children: [
                buildListItem(
                  title: 'Change Channel Name',
                  icon: Icons.abc,
                  onCliked: () {},
                ),
                buildListItem(
                  title: 'Change Channel Avatar Image',
                  icon: MdiIcons.imageOutline,
                  onCliked: () {},
                ),
                buildListItem(
                  title: 'Members',
                  icon: MdiIcons.accountMultipleOutline,
                  onCliked: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildListItem({
  required String title,
  required IconData icon,
  VoidCallback? onCliked,
}) {
  return ListTile(
    contentPadding:
        EdgeInsets.symmetric(horizontal: Get.mediaQuery.size.width * 0.05),
    trailing: Icon(
      icon,
      color: Get.isDarkMode ? kButtonColorDarkTheme : kButtonColorLightTheme,
    ),
    title: Text(
      title,
      style: TextStyle(
        color: Get.isDarkMode ? kButtonColorDarkTheme : kButtonColorLightTheme,
      ),
    ),
    onTap: onCliked,
  );
}
