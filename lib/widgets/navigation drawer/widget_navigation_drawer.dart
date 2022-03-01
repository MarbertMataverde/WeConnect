import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:weconnect/constant/constant_colors.dart';
import 'package:weconnect/controller/controller_theme_changer.dart';

import '../../page/phone view/home/report/report_list.dart';

final changeTheme = Get.put(ControllerChangeTheme());

class WidgetNavigationDrawer extends StatelessWidget {
  const WidgetNavigationDrawer({Key? key, required this.accountType})
      : super(key: key);

  final String accountType;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Get.isDarkMode
            ? kTextFormFieldColorDarkTheme
            : kTextFormFieldColorLightTheme,
        child: ListView(
          children: <Widget>[
            //theme changer
            buildDrawerItem(
              icon: MdiIcons.themeLightDark,
              title: 'Theme',
              onCliked: () => selectedItem(context, 0),
            ),
            //reported post
            Visibility(
              visible: accountType == 'accountTypeCampusAdmin' ||
                  accountType == 'accountTypeRegistrarAdmin',
              child: buildDrawerItem(
                icon: Icons.report_outlined,
                title: 'Reports',
                onCliked: () => selectedItem(context, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildDrawerItem({
  required String title,
  required IconData icon,
  VoidCallback? onCliked,
}) {
  return ListTile(
    leading: Icon(
      icon,
      color: Get.isDarkMode ? kButtonColorDarkTheme : kButtonColorLightTheme,
    ),
    title: Text(
      title,
      style: TextStyle(
        color: Get.isDarkMode ? kButtonColorDarkTheme : kButtonColorLightTheme,
      ),
    ),
    onTap: onCliked,
  );
}

void selectedItem(BuildContext context, int index) {
  Get.back();
  switch (index) {
    case 0:
      changeTheme.toggleChangeTheme();
      break;
    case 1:
      Get.to(() => const ReportList());
      break;
    default:
  }
}
