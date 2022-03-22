import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weconnect/page/phone%20view/home/drawer/about/about.dart';
import '../../page/phone%20view/home/drawer/forum%20topic%20request/forum_topic_request_list.dart';

import '../../authentication/authentication_controller.dart';
import '../../page/phone view/home/drawer/edit account/edit_account.dart';
import '../../page/phone view/home/drawer/report/report_list.dart';

final authentication = Get.put(Authentication());

void selectedItem(
  BuildContext context,
  int index,
) {
  Get.back();
  switch (index) {
    case 0:
      //Edit Personal Information
      Get.to(() => const EditAccount());
      break;
    case 2:
      Get.to(() => const ForumTopicRequestList());
      break;
    case 3:
      //report list
      Get.to(() => const ReportList());
      break;
    case 5:
      //about
      Get.to(() => const About());
      break;
    case 10:
      authentication.signOut();
      break;
    default:
  }
}
