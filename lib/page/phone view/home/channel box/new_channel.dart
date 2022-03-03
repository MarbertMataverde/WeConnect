import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constant/constant_colors.dart';
import '../../../../widgets/appbar title/appbar_title.dart';
import '../../../../widgets/navigation drawer/widget_navigation_drawer.dart';

class NewChannel extends StatefulWidget {
  const NewChannel({Key? key}) : super(key: key);

  @override
  State<NewChannel> createState() => _NewChannelState();
}

class _NewChannelState extends State<NewChannel> {
  String? accountType;
  String? studentCollege;
  @override
  void initState() {
    accountTypeGetter();
    super.initState();
  }

  Future accountTypeGetter() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      accountType = sharedPreferences.get('accountType').toString();
      studentCollege = sharedPreferences.get('studentCollege').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: WidgetNavigationDrawer(
        accountType: accountType.toString(),
        studentCollege: studentCollege.toString(),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: const AppBarTitle(
          title: 'Channel List',
        ),
        actions: [
          Visibility(
            visible: accountType == 'accountTypeProfessor',
            child: IconButton(
              tooltip: 'New Channel Box',
              onPressed: () {},
              icon: Icon(
                MdiIcons.messagePlusOutline,
                color: Get.isDarkMode
                    ? kButtonColorDarkTheme
                    : kButtonColorLightTheme,
              ),
            ),
          ),
          Builder(
            builder: ((context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: Icon(
                  MdiIcons.menu,
                  color: Get.isDarkMode
                      ? kButtonColorDarkTheme
                      : kButtonColorLightTheme,
                ),
              );
            }),
          ),
        ],
      ),
      body: Center(
        child: Text('Channel Box'),
      ),
    );
  }
}
