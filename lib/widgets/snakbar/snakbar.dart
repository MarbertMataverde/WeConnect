import 'package:flutter/material.dart';

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
