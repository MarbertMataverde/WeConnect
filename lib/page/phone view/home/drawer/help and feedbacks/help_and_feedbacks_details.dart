import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';

import '../../../../../widgets/appbar/build_appbar.dart';

class HelpAndFeedBacksDetails extends StatelessWidget {
  const HelpAndFeedBacksDetails(
      {Key? key,
      required this.senderImageUrl,
      required this.senderName,
      required this.senderMessage})
      : super(key: key);

  final String senderImageUrl;
  final String senderName;
  final String senderMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: 'Details',
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Iconsax.arrow_square_left,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: AvatarGlow(
                glowColor: Theme.of(context).primaryColor,
                endRadius: 10.h,
                duration: const Duration(milliseconds: 2000),
                repeat: true,
                showTwoGlows: true,
                repeatPauseDuration: const Duration(milliseconds: 100),
                child: Material(
                  // Replace this child with your own
                  elevation: 8.0,
                  shape: const CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    child: Image.network(
                      senderImageUrl,
                      height: 60,
                    ),
                    radius: 40.0,
                  ),
                ),
              ),
            ),
            Text(
              senderName,
              textScaleFactor: 1.2,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Message:',
                  textScaleFactor: 1.1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                senderMessage,
                textScaleFactor: 1,
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
