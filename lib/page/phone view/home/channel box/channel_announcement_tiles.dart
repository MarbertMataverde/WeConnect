import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget buildAnnouncementChannelTile({
  required BuildContext context,
  required String announcementMessage,
  required List announcementImageList,
  required List announcementFileList,
  required Timestamp announcementCreatedAt,
}) {
  return Container(
    color: Theme.of(context).primaryColor,
    height: 20,
    width: 50,
  );
}
