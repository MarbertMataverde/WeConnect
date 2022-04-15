import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../widgets/appbar/build_appbar.dart';

import '../../../../widgets/snakbar/snakbar.dart';

class ChannelSettings extends StatelessWidget {
  const ChannelSettings(
      {Key? key,
      required this.channelAvatarImage,
      required this.channelName,
      required this.channelToken})
      : super(key: key);

  final String channelAvatarImage;
  final String channelName;
  final String channelToken;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: 'Settings',
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Iconsax.arrow_square_left,
              color: Theme.of(context).iconTheme.color,
            )),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.width * 0.15,
            backgroundImage: NetworkImage(channelAvatarImage),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
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
                  context: context,
                  title: channelToken,
                  icon: Iconsax.copy,
                  iconColor: Theme.of(context).primaryColor,
                  onCliked: () {
                    Clipboard.setData(ClipboardData(text: channelToken)).then(
                      (value) => buildCustomSnakbar(
                          context: context,
                          icon: Iconsax.copy,
                          message: 'Token copied to clipboard'),
                    );
                  },
                ),
                buildListItem(
                  context: context,
                  title: 'Change Channel Name',
                  icon: Iconsax.edit_2,
                  onCliked: () {},
                ),
                buildListItem(
                  context: context,
                  title: 'Change Channel Avatar Image',
                  icon: Iconsax.gallery_edit,
                  onCliked: () {},
                ),
                buildListItem(
                  context: context,
                  title: 'Members',
                  icon: Iconsax.profile_2user,
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
  required BuildContext context,
  required String title,
  required IconData icon,
  Color? iconColor,
  VoidCallback? onCliked,
}) {
  return ListTile(
    contentPadding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05),
    trailing: Icon(
      icon,
      color: iconColor ?? Theme.of(context).iconTheme.color,
    ),
    title: Text(
      title,
      style: TextStyle(
        color: Theme.of(context).textTheme.bodyMedium!.color,
      ),
    ),
    onTap: onCliked,
  );
}
