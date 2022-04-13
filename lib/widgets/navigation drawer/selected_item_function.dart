import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weconnect/page/phone%20view/home/drawer/terms%20and%20condition/term_and_condition.dart';
import '../../page/phone view/home/drawer/mvg/mvg.dart';
import '../../page/phone%20view/home/drawer/about/about.dart';
import '../../page/phone%20view/home/drawer/gallery/gallery.dart';
import '../../page/phone%20view/home/drawer/student%20downloadable%20forms/downloadable_forms.dart';
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
    // edit account
    case 0:
      Get.to(() => const EditAccount());
      break;
    // forum topic request
    case 1:
      Get.to(() => const ForumTopicRequestList());
      break;
    // announcement reports
    case 2:
      Get.to(() => const ReportList());
      break;
    // about
    case 3:
      Get.to(() => const About());
      break;
    // gallery
    case 4:
      Get.to(() => const Gallery());
      break;
    // Mission Vision Goal of URS
    case 5:
      Get.to(() => const MVC());
      break;
    // downloadable forms
    case 6:
      Get.to(() => const DownloadForms());
      break;
    // Terms and Condition
    case 7:
      Get.to(() => const TermsAndCondition());
      break;
     // Help & Feedback
    // case 8:
    //   Get.to(() => const HelpAndFeedback());
    //   break;
    case 9:
      authentication.signOut();
      break;
    default:
  }
}
