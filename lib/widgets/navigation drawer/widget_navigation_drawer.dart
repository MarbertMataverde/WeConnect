import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import '../../controller/controller_account_information.dart';

import 'drawer_items.dart';
import 'named_divider.dart';
import 'selected_item_function.dart';

//accessing global box
final box = GetStorage();

class WidgetNavigationDrawer extends StatefulWidget {
  const WidgetNavigationDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<WidgetNavigationDrawer> createState() => _WidgetNavigationDrawerState();
}

class _WidgetNavigationDrawerState extends State<WidgetNavigationDrawer> {
  final isLightTheme = true;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        children: <Widget>[
          drawerProfileHeader(
            onCliked: () {},
            profileAccountCollegeType:
                currentAccountType == 'accountTypeCampusAdmin'
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
          //theme divider
          // namedDivider(context: context, dividerName: 'Account'),
          //theme items
          // drawerItems(
          //   context: context,
          //   title: 'Toggle Theme',
          //   icon: isLightTheme ? Iconsax.sun_1 : Iconsax.moon,
          //   onCliked: () {
          //     currentTheme.switchTheme();
          //   },
          // ),
          // //account divider
          // namedDivider(context: context, dividerName: 'Account'),
          // //account items
          // drawerItems(
          //   context: context,
          //   title: 'Edit Account',
          //   icon: Iconsax.user_edit,
          //   onCliked: () => selectedItem(context, 0),
          // ),
          // drawerItems(
          //   context: context,
          //   title: 'Edit Sign In Details',
          //   icon: Iconsax.sms_edit,
          //   onCliked: () {},
          // ),

          //reported post
          Visibility(
            visible: currentAccountType == 'accountTypeCampusAdmin' ||
                currentAccountType == 'accountTypeRegistrarAdmin',
            child: Column(
              children: [
                //issue divider
                namedDivider(context: context, dividerName: 'Issues'),
                drawerItems(
                  context: context,
                  icon: Iconsax.judge,
                  title: 'Forum Topic Request',
                  onCliked: () => selectedItem(context, 1),
                ),
                drawerItems(
                  context: context,
                  icon: Iconsax.warning_2,
                  title: 'Announcement Reports',
                  onCliked: () => selectedItem(context, 2),
                ),
                drawerItems(
                  context: context,
                  icon: Iconsax.warning_2,
                  title: 'Forum Topic Reports',
                  onCliked: () => selectedItem(context, 21),
                ),
              ],
            ),
          ),
          //campus divider
          namedDivider(context: context, dividerName: 'Campus'),
          //campus items
          drawerItems(
            context: context,
            title: 'About',
            icon: Iconsax.people,
            onCliked: () => selectedItem(context, 3),
          ),
          drawerItems(
            context: context,
            title: 'Gallery',
            icon: Iconsax.gallery,
            onCliked: () => selectedItem(context, 4),
          ),
          drawerItems(
            context: context,
            title: 'Vision Mission Goals',
            icon: Iconsax.book,
            onCliked: () {
              selectedItem(context, 5);
            },
          ),
          drawerItems(
            context: context,
            title: 'Downloadable Forms',
            icon: Iconsax.document_download,
            onCliked: () {
              selectedItem(context, 6);
            },
          ),
          //others divider
          namedDivider(context: context, dividerName: 'Others'),
          //others items
          drawerItems(
            context: context,
            title: 'Terms and Condition',
            icon: Iconsax.document,
            onCliked: () {
              selectedItem(context, 7);
            },
          ),
          // send help and feedback
          Visibility(
            visible: currentAccountType != 'accountTypeCampusAdmin',
            child: drawerItems(
              context: context,
              title: 'Help & Feedback',
              icon: Iconsax.lifebuoy,
              onCliked: () {
                selectedItem(context, 8);
              },
            ),
          ),
          // help and feedbacks
          Visibility(
            visible: currentAccountType == 'accountTypeCampusAdmin',
            child: drawerItems(
              context: context,
              title: 'Help & Feedbacks',
              icon: Iconsax.lifebuoy,
              onCliked: () {
                selectedItem(context, 81);
              },
            ),
          ),
          //sign out divider
          namedDivider(context: context),
          drawerItems(
            context: context,
            title: 'Sign Out',
            icon: Iconsax.logout,
            onCliked: () {
              selectedItem(context, 9);
            },
          ),
        ],
      ),
    );
  }
}

Widget drawerProfileHeader({
  required String profileImageUrl,
  required String profileName,
  required String profileAccountCollegeType,
  VoidCallback? onCliked,
}) {
  return InkWell(
    onTap: onCliked,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                profileName,
                textScaleFactor: 1.1,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                profileAccountCollegeType,
                textScaleFactor: 0.7,
                style: const TextStyle(),
              ),
            ],
          ),
          SizedBox(
            width: 1.w,
          ),
          CircleAvatar(
            backgroundColor: Colors.transparent,
            child: ClipOval(
              child: Image.network(
                profileImageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
