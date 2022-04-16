import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weconnect/page/phone%20view/home/channel%20box/channel_edit_channel_name.dart';
import '../../../../widgets/appbar/build_appbar.dart';

import '../../../../widgets/snakbar/snakbar.dart';

class ChannelSettings extends StatefulWidget {
  const ChannelSettings(
      {Key? key,
      required this.channelAvatarImage,
      required this.channelName,
      required this.channelToken,
      required this.channelDocId})
      : super(key: key);

  final String channelAvatarImage;
  final String channelName;
  final String channelToken;
  final String channelDocId;

  @override
  State<ChannelSettings> createState() => _ChannelSettingsState();
}

class _ChannelSettingsState extends State<ChannelSettings> {
  // File? selectedImage;
  // Future pickImage() async {
  //   try {
  //     final selectedImage =
  //         await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if (selectedImage == null) {
  //       return;
  //     }
  //     final selectedTempImage = File(selectedImage.path);
  //     setState(() {
  //       this.selectedImage = selectedTempImage;
  //     });
  //   } on PlatformException catch (e) {
  //     debugPrint('Failed to pick image: $e');
  //   }
  // }

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
          ),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: selectedImage != null
        //         ? () async {
        //             channel.changeChannelAvatar(
        //               context: context,
        //               avatarStorageRefUrl: widget.channelAvatarImage,
        //               filePath: selectedImage.toString(),
        //               channelName: widget.channelName,
        //               channelToken: widget.channelToken,
        //               channelDocId: widget.channelDocId,
        //             );
        //           }
        //         : null,
        //     icon: Icon(
        //       Iconsax.tick_square,
        //       color: selectedImage != null
        //           ? Theme.of(context).primaryColor
        //           : Theme.of(context).disabledColor,
        //     ),
        //   ),
        // ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.width * 0.15,
            backgroundImage: NetworkImage(widget.channelAvatarImage),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Text(
            widget.channelName,
            textScaleFactor: 1.5,
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: ListView(
              children: [
                buildListItem(
                  context: context,
                  title: widget.channelToken,
                  icon: Iconsax.copy,
                  iconColor: Theme.of(context).primaryColor,
                  onCliked: () {
                    Clipboard.setData(ClipboardData(text: widget.channelToken))
                        .then(
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
                  onCliked: () => Get.to(
                    () => EditChannelName(
                      currentName: widget.channelName,
                      token: widget.channelToken,
                    ),
                  ),
                ),
                // buildListItem(
                //   context: context,
                //   title: 'Change Channel Avatar Image',
                //   icon: Iconsax.gallery_edit,
                //   onCliked: () async {
                //     pickImage();
                //   },
                // ),
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
