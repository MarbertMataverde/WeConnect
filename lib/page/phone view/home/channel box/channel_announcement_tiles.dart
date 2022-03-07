import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChannelAnnouncementTiles extends StatelessWidget {
  const ChannelAnnouncementTiles({
    Key? key,
    required this.announcementMessage,
    required this.announcementCreatedAt,
    required this.announcementMedia,
    required this.announcementUploadedFileUrl,
  }) : super(key: key);

  final String announcementMessage;
  final Timestamp announcementCreatedAt;
  final List announcementMedia;
  final String announcementUploadedFileUrl;

  @override
  Widget build(BuildContext context) {
    return buildAnnouncementTile();
  }
}

Widget buildAnnouncementTile({
  String? announcementMessage,
}) {
  return Text(announcementMessage.toString());
}
