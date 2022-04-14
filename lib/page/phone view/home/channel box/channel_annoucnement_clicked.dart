import 'package:flutter/material.dart';
import 'package:linkwell/linkwell.dart';
import 'package:sizer/sizer.dart';
import '../../../phone%20view/home/channel%20box/channel_announcement_tile.dart';
import '../../../../widgets/appbar/appbar_back.dart';

class ChannelTileCliked extends StatelessWidget {
  const ChannelTileCliked(
      {Key? key,
      required this.announcementImageList,
      required this.announcementMessage})
      : super(key: key);

  final List announcementImageList;
  final String announcementMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: buildAppbarBackButton(context: context),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: announcementImageList.length == 1
                  ? singleImage(announcementImageList)
                  : carouselSlider(
                      announcementImageList,
                      context: context,
                    ),
            ),
            Padding(
              padding: EdgeInsets.all(5.w),
              child: LinkWell(
                announcementMessage,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
                linkStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
