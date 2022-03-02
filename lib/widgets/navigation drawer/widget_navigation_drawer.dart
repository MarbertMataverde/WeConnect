import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/constant/constant_colors.dart';
import 'package:weconnect/controller/controller_theme_changer.dart';

import '../../page/phone view/home/report/report_list.dart';

final changeTheme = Get.put(ControllerChangeTheme());

//accessing global box
final box = GetStorage();

class WidgetNavigationDrawer extends StatelessWidget {
  const WidgetNavigationDrawer(
      {Key? key, required this.accountType, required this.studentCollege})
      : super(key: key);

  final String accountType;
  final String studentCollege;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Get.isDarkMode
            ? kTextFormFieldColorDarkTheme
            : kTextFormFieldColorLightTheme,
        child: ListView(
          children: <Widget>[
            buildProfileHeader(
              onCliked: () {},
              profileAccountCollegeType: accountType == 'accountTypeCampusAdmin'
                  ? 'Campus Admin'
                  : accountType == 'accountTypeRegistrarAdmin'
                      ? 'Registrar Admin'
                      : accountType == 'accountTypeCoaAdmin'
                          ? 'College of Accountancy Admin'
                          : accountType == 'accountTypeCobAdmin'
                              ? 'College of Business Admin'
                              : accountType == 'accountTypeCcsAdmin'
                                  ? 'College of Computer Studies Admin'
                                  : accountType == 'accountTypeMasteralAdmin'
                                      ? 'Masteral Admin'
                                      : accountType == 'accountTypeProfessor'
                                          ? 'Professor'
                                          : studentCollege,
              profileImageUrl: box.read('profileImageUrl'),
              profileName: box.read('profileName'),
            ),
            //account divider
            namedDivider(dividerName: 'Account'),
            //account items
            buildDrawerItem(
              title: 'Edit Personal Information',
              icon: MdiIcons.noteEditOutline,
              onCliked: () {},
            ),
            buildDrawerItem(
              title: 'Edit Sign In Details',
              icon: MdiIcons.emailOutline,
              onCliked: () {},
            ),

            //reported post
            Visibility(
              visible: accountType == 'accountTypeCampusAdmin' ||
                  accountType == 'accountTypeRegistrarAdmin',
              child: Column(
                children: [
                  //issue divider
                  namedDivider(dividerName: 'Issues'),
                  buildDrawerItem(
                    icon: Icons.report_outlined,
                    title: 'Reports',
                    onCliked: () => selectedItem(context, 1),
                  ),
                ],
              ),
            ),
            //campus divider
            namedDivider(dividerName: 'Campus'),
            //campus items
            buildDrawerItem(
              title: 'About',
              icon: MdiIcons.accountQuestionOutline,
              onCliked: () {},
            ),
            buildDrawerItem(
              title: 'Gallery',
              icon: MdiIcons.imageFrame,
              onCliked: () {},
            ),
            buildDrawerItem(
              title: 'Vision Mission Goals',
              icon: MdiIcons.target,
              onCliked: () {},
            ),
            buildDrawerItem(
              title: 'Downloadable Forms',
              icon: MdiIcons.downloadBoxOutline,
              onCliked: () {},
            ),
            //others divider
            namedDivider(dividerName: 'Others'),
            //others items
            buildDrawerItem(
              title: 'Terms and Condition',
              icon: MdiIcons.fileOutline,
              onCliked: () {},
            ),
            buildDrawerItem(
              title: 'Privacy Policy',
              icon: MdiIcons.shieldAccountVariantOutline,
              onCliked: () {},
            ),
            buildDrawerItem(
              title: 'Help & Feedback',
              icon: MdiIcons.lifebuoy,
              onCliked: () {},
            ),
            //sign out divider
            Divider(
              height: 0,
              indent: 5.w,
              endIndent: 5.w,
              thickness: 0.5,
              color: Get.isDarkMode
                  ? kButtonColorDarkTheme
                  : kButtonColorLightTheme,
            ),
            buildDrawerItem(
              title: 'Sign Out',
              icon: MdiIcons.logout,
              onCliked: () {},
            ),
          ],
        ),
      ),
    );
  }
}

Widget namedDivider({required String dividerName}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //account
      Padding(
        padding: EdgeInsets.only(left: 5.w),
        child: Text(
          dividerName,
          textScaleFactor: 1.1,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      //divider
      Divider(
        height: 0,
        indent: 5.w,
        endIndent: 5.w,
        thickness: 0.5,
        color: Get.isDarkMode ? kButtonColorDarkTheme : kButtonColorLightTheme,
      ),
    ],
  );
}

Widget buildProfileHeader({
  required String profileImageUrl,
  required String profileName,
  required String profileAccountCollegeType,
  VoidCallback? onCliked,
}) {
  return InkWell(
    onTap: onCliked,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      child: SizedBox(
        width: 100.w,
        height: 10.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  profileName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  profileAccountCollegeType,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 7.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 1.w,
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(profileImageUrl),
              radius: 4.h,
            )
          ],
        ),
      ),
    ),
  );
}

Widget buildDrawerItem({
  required String title,
  required IconData icon,
  VoidCallback? onCliked,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 5.w),
    child: ListTile(
      trailing: Icon(
        icon,
        color: Get.isDarkMode ? kButtonColorDarkTheme : kButtonColorLightTheme,
      ),
      title: Text(
        title,
        style: TextStyle(
          color:
              Get.isDarkMode ? kButtonColorDarkTheme : kButtonColorLightTheme,
        ),
      ),
      onTap: onCliked,
    ),
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
