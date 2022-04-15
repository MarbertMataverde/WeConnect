import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../controller/controller_report.dart';
import '../../../../../widgets/appbar/build_appbar.dart';
import 'announcement_detailed_report.dart';

final Stream<QuerySnapshot> reportStream = FirebaseFirestore.instance
    .collection('reports')
    .orderBy('reported-at', descending: true)
    .snapshots();

//report controller
final report = Get.put(ControllerReport());

class AnnouncementReportList extends StatelessWidget {
  const AnnouncementReportList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: 'Reports',
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Iconsax.arrow_square_left,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: reportStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          final data = snapshot.requireData;

          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              Timestamp reportedAt = data.docs[index]['reported-at'];
              return Card(
                child: Slidable(
                  endActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (_) {
                          Get.to(
                            () => AnnouncementDetailedReport(
                              //reported post tile
                              reportType: data.docs[index]['report-type'],
                              postDocId: data.docs[index]['post-documment-id'],
                              //reporter concerns
                              reportedAt: data.docs[index]['reported-at'],
                              reporterName: data.docs[index]['reporter-name'],
                              reporterProfileImageUrl: data.docs[index]
                                  ['reporter-profile-image-url'],
                              reportedConcern: data.docs[index]
                                  ['report-concern'],
                              reportedConcernDescription: data.docs[index]
                                  ['report-concern-description'],
                              //dismissal
                              reportDocId: data.docs[index].id,
                            ),
                          );
                        },
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        icon: Iconsax.glass_1,
                        label: 'Review',
                      ),
                      SlidableAction(
                        onPressed: (_) {
                          report.dismissReport(
                            context: context,
                            title: 'Report Dismissal',
                            assetLocation: 'assets/gifs/dismiss_report.gif',
                            description:
                                'Are you sure you want to dissmiss this issue?',
                            reportDocType: 'announcement-report',
                            reportDocId: data.docs[index].id,
                          );
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Iconsax.close_square,
                        label: 'Dismiss',
                      ),
                    ],
                  ),
                  child: ListTile(
                    onTap: () {
                      Get.to(
                        () => AnnouncementDetailedReport(
                          //reported post tile
                          reportType: data.docs[index]['report-type'],
                          postDocId: data.docs[index]['post-documment-id'],
                          //reporter concerns
                          reportedAt: data.docs[index]['reported-at'],
                          reporterName: data.docs[index]['reporter-name'],
                          reporterProfileImageUrl: data.docs[index]
                              ['reporter-profile-image-url'],
                          reportedConcern: data.docs[index]['report-concern'],
                          reportedConcernDescription: data.docs[index]
                              ['report-concern-description'],
                          reportDocId: data.docs[index].id,
                        ),
                      );
                    },
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(5.w),
                      child: Image.network(
                        data.docs[index]['reporter-profile-image-url'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      data.docs[index]['reporter-name'],
                      textScaleFactor: 1.1,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      data.docs[index]['report-concern-description'],
                      overflow: TextOverflow.ellipsis,
                      textScaleFactor: 0.9,
                      style: TextStyle(
                        height: 1.2,
                        color: Theme.of(context).textTheme.labelMedium!.color,
                      ),
                    ),
                    trailing: Text(timeago.format(reportedAt.toDate(),
                        locale: 'en_short')),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
