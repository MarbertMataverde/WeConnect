import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../page/phone view/home/drawer/edit account/edit_account.dart';
import '../../page/phone view/home/drawer/report/report_list.dart';

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
    case 1:
      Get.to(() => const ReportList());
      break;
    default:
  }
}
