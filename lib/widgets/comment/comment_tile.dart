import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;

Widget buildCommentTile({
  required BuildContext context,
  required String profileImageUrl,
  required String profileName,
  required Timestamp commentedDate,
  required String comment,
}) {
  return ListTile(
    leading: CircleAvatar(
      backgroundColor: Colors.transparent,
      child: ClipOval(
        child: Image.network(
          profileImageUrl,
          fit: BoxFit.cover,
        ),
      ),
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          profileName,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium!.color,
          ),
        ),
        Text(
          timeago.format(
            commentedDate.toDate(),
          ),
          textScaleFactor: 0.6,
          style: TextStyle(
            color: Theme.of(context).textTheme.labelMedium!.color,
          ),
        ),
      ],
    ),
    subtitle: Padding(
      padding: EdgeInsets.only(top: 1.h),
      child: ExpandableText(
        comment,
        maxLines: 3,
        expandText: 'read more 📖',
        collapseText: 'collapse 📕',
        expandOnTextTap: true,
        collapseOnTextTap: true,
        animation: true,
        animationCurve: Curves.fastLinearToSlowEaseIn,
        linkStyle: TextStyle(
          color: Theme.of(context).primaryColor,
        ),
        style: TextStyle(
          color: Theme.of(context).textTheme.labelMedium!.color,
        ),
      ),
    ),
  );
}
