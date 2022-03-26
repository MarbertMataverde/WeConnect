import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../authentication/authentication_controller.dart';
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
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'WeConnect',
          textScaleFactor: 1.5,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              authentication.signOut();
            },
            icon: Icon(
              Iconsax.logout,
              color: Theme.of(context).iconTheme.color,
            ),
          )
        ],
      ),
      body: const StudentAxCodeGenerator(),
    );
  }
}
