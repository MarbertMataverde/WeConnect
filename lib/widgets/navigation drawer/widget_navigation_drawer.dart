import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../controller/controller_account_information.dart';

import '../../constant/constant_colors.dart';
import '../../controller/controller_theme_changer.dart';
import 'drawer_items.dart';
import 'named_divider.dart';
import 'profile_header.dart';
import 'selected_item_function.dart';

final changeTheme = Get.put(ControllerChangeTheme());

//accessing global box
final box = GetStorage();

class WidgetNavigationDrawer extends StatelessWidget {
  const WidgetNavigationDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Get.isDarkMode
            ? kTextFormFieldColorDarkTheme
            : kTextFormFieldColorLightTheme,
        child: ListView(
          children: <Widget>[
            drawerProfileHeader(
              onCliked: () {},
              profileAccountCollegeType: currentAccountType ==
                      'accountTypeCampusAdmin'
                  ? 'Campus Admin'
                  : currentAccountType == 'accountTypeRegistrarAdmin'
                      ? 'Registrar Admin'
                      : currentAccountType == 'accountTypeCoaAdmin'
                          ? 'College of Accountancy Admin'
                          : currentAccountType == 'accountTypeCobAdmin'
                              ? 'College of Business Admin'
                              : currentAccountType == 'accountTypeCcsAdmin'
                                  ? 'College of Computer Studies Admin'
                                  : currentAccountType ==
                                          'accountTypeMasteralAdmin'
                                      ? 'Masteral Admin'
                                      : currentAccountType ==
                                              'accountTypeProfessor'
                                          ? 'Professor'
                                          : currentStudentCollege.toString(),
              profileImageUrl: currentProfileImageUrl.toString(),
              profileName: currentProfileName.toString(),
            ),
            //account divider
            namedDivider(dividerName: 'Account'),
            //account items
            drawerItems(
              title: 'Edit Account',
              icon: MdiIcons.accountEditOutline,
              onCliked: () {
                selectedItem(context, 0);
              },
            ),
            drawerItems(
              title: 'Edit Sign In Details',
              icon: MdiIcons.emailOutline,
              onCliked: () {},
            ),

            //reported post
            Visibility(
              visible: currentAccountType == 'accountTypeCampusAdmin' ||
                  currentAccountType == 'accountTypeRegistrarAdmin',
              child: Column(
                children: [
                  //issue divider
                  namedDivider(dividerName: 'Issues'),
                  drawerItems(
                    icon: Icons.report_outlined,
                    title: 'Reports',
                    onCliked: () => selectedItem(context, 2),
                  ),
                ],
              ),
            ),
            //campus divider
            namedDivider(dividerName: 'Campus'),
            //campus items
            drawerItems(
              title: 'About',
              icon: MdiIcons.accountQuestionOutline,
              onCliked: () {
                selectedItem(context, 3);
              },
            ),
            drawerItems(
              title: 'Gallery',
              icon: MdiIcons.imageFrame,
              onCliked: () {
                selectedItem(context, 4);
              },
            ),
            drawerItems(
              title: 'Vision Mission Goals',
              icon: MdiIcons.target,
              onCliked: () {
                selectedItem(context, 5);
              },
            ),
            drawerItems(
              title: 'Downloadable Forms',
              icon: MdiIcons.downloadBoxOutline,
              onCliked: () {
                selectedItem(context, 6);
              },
            ),
            //others divider
            namedDivider(dividerName: 'Others'),
            //others items
            drawerItems(
              title: 'Terms and Condition',
              icon: MdiIcons.fileOutline,
              onCliked: () {
                selectedItem(context, 7);
              },
            ),
            drawerItems(
              title: 'Privacy Policy',
              icon: MdiIcons.shieldAccountVariantOutline,
              onCliked: () {
                selectedItem(context, 8);
              },
            ),
            drawerItems(
              title: 'Help & Feedback',
              icon: MdiIcons.lifebuoy,
              onCliked: () {
                selectedItem(context, 9);
              },
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
            drawerItems(
              title: 'Sign Out',
              icon: MdiIcons.logout,
              onCliked: () {
                selectedItem(context, 10);
              },
            ),
          ],
        ),
      ),
    );
  }
}
