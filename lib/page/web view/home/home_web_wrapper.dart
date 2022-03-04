import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../authentication/authentication_controller.dart';
import '../../../constant/constant_colors.dart';
import 'home_student_axcode.dart';

final authentication = Get.put(Authentication());

class HomeWebWrapper extends StatefulWidget {
  const HomeWebWrapper({Key? key}) : super(key: key);

  @override
  State<HomeWebWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWebWrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: const Text('WeConnect'),
        actions: [
          IconButton(
            onPressed: () {
              authentication.signOut();
            },
            icon: Icon(
              MdiIcons.logout,
              color: Get.isDarkMode
                  ? kButtonColorDarkTheme
                  : kButtonColorLightTheme,
            ),
          )
        ],
      ),
      body: const StudentAxCodeGenerator(),
    );
  }
}
