import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget drawerItems({
  required BuildContext context,
  required String title,
  required IconData icon,
  VoidCallback? onCliked,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 5.w),
    child: ListTile(
      trailing: Icon(
        icon,
        color: Theme.of(context).iconTheme.color,
      ),
      title: Text(
        title,
      ),
      onTap: onCliked,
    ),
  );
}
