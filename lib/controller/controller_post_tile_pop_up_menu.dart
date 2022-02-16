import 'package:flutter/material.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ControllerPostTilePopUpMenu extends GetxController {
//menu item for campus and registrar admin
  List<FocusedMenuItem> campusAndRegistrarAdminMenuItem = [
    // Add Each FocusedMenuItem  for Menu Options
    focusMenuItem(
      'Details',
      MdiIcons.details,
      Colors.black54,
      () {},
    ),
    focusMenuItem(
      'Edit Post',
      MdiIcons.pencil,
      Colors.black54,
      () {},
    ),

    focusMenuItem(
      'Delete',
      Icons.delete_outlined,
      Colors.red,
      () {},
    ),
  ];

//menu item for professors and students
  List<FocusedMenuItem> professorsAndStudentsMenuItem = [
    focusMenuItem(
      'Details',
      MdiIcons.details,
      Colors.black54,
      () {},
    ),
    focusMenuItem(
      'Report',
      Icons.report_outlined,
      Colors.red,
      () {},
    ),
  ];
}

FocusedMenuItem focusMenuItem(
  String title,
  IconData trailingIcon,
  Color iconColor,
  Function onPressed,
) {
  return FocusedMenuItem(
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.black,
      ),
    ),
    trailingIcon: Icon(
      trailingIcon,
      color: iconColor,
    ),
    onPressed: onPressed,
  );
}
