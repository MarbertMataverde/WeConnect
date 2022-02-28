import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../page/phone view/reports/report_details.dart';

class ReportTile extends StatelessWidget {
  const ReportTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.to(() => ReportDetails(
              data: data,
            ));
      },
      leading: CircleAvatar(
        backgroundImage: NetworkImage(data['reporter-profile-image-url']),
      ),
      title: Text(data['reporter-name']),
      subtitle: Text(
        data['report-description'],
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
