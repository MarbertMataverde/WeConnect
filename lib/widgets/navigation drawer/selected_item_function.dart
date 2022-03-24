import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weconnect/page/phone%20view/home/drawer/MVG/mvg.dart';
import 'package:weconnect/page/phone%20view/home/drawer/about/about.dart';
import 'package:weconnect/page/phone%20view/home/drawer/gallery/gallery.dart';
import 'package:weconnect/page/phone%20view/home/drawer/student%20downloadable%20forms/downloadable_forms.dart';
import 'package:weconnect/page/phone%20view/home/drawer/terms%20and%20condition/terms_and_condition.dart';
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
    case 6:
      //gallery
      Get.to(() => const Gallery());
      break;
    case 7:
      //Mission Vision Goal of URS
      Get.to(() => const MVG());
      break;
    case 8:
      //Downlodable forms
      Get.to(() => const DownloadForms());
      break;
    case 9:
      Get.to(() => const TermsAndCondition());
      break;
    case 10:
      authentication.signOut();
      break;
    default:
  }
}
