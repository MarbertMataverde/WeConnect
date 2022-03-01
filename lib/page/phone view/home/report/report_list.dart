import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/controller/controller_report.dart';

import '../../../../constant/constant_colors.dart';
import '../../../../widgets/appbar title/appbar_title.dart';

final Stream<QuerySnapshot> reportStream =
    FirebaseFirestore.instance.collection('reports').snapshots();

//report controller
final report = Get.put(ControllerReport());

class ReportList extends StatelessWidget {
  const ReportList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              MdiIcons.arrowLeft,
              color: Get.isDarkMode
                  ? kButtonColorDarkTheme
                  : kButtonColorLightTheme,
            )),
        centerTitle: true,
        title: const AppBarTitle(
          title: 'Report List',
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
              return Slidable(
                endActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (_) {},
                      backgroundColor: Get.theme.primaryColor,
                      foregroundColor: Colors.white,
                      icon: MdiIcons.newspaperVariantOutline,
                      label: 'View Post',
                    ),
                    SlidableAction(
                      onPressed: (_) {
                        report.dismissReport(
                          context: context,
                          title: 'Report Dismissal',
                          assetLocation: 'assets/gifs/dismiss_report.gif',
                          description:
                              'Are you sure you want to dissmiss this issue?',
                          reportDocId: data.docs[index].id,
                        );
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete_outline,
                      label: 'Dismiss',
                    ),
                  ],
                ),
                child: ListTile(
                  tileColor: Get.isDarkMode
                      ? kTextFormFieldColorDarkTheme
                      : kTextFormFieldColorLightTheme,
                  onTap: () {},
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        data.docs[index]['reporter-profile-image-url']),
                  ),
                  title: Text(data.docs[index]['reporter-name']),
                  subtitle: Text(
                    data.docs[index]['report-concern-description'],
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            },
          );
          // return ListView(
          //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
          //     Map<String, dynamic> data =
          //         document.data()! as Map<String, dynamic>;
          //     final dataId = snapshot.requireData;
          //     return Slidable(
          //       endActionPane: ActionPane(
          //         motion: const StretchMotion(),
          //         children: [
          //           SlidableAction(
          //             onPressed: (_) {},
          //             backgroundColor: Get.theme.primaryColor,
          //             foregroundColor: Colors.white,
          //             icon: MdiIcons.newspaperVariantOutline,
          //             label: 'View Post',
          //           ),
          //           SlidableAction(
          //             onPressed: (_) {
          //             },
          //             backgroundColor: Colors.red,
          //             foregroundColor: Colors.white,
          //             icon: Icons.delete_outline,
          //             label: 'Dismiss',
          //           ),
          //         ],
          //       ),
          //       child: reportListTile(
          //         reportData: data,
          //       ),
          //     );
          //   }).toList(),
          // );
        },
      ),
    );
  }
}

Widget reportListTile({
  required reportData,
}) {
  return ListTile(
    tileColor: Get.isDarkMode
        ? kTextFormFieldColorDarkTheme
        : kTextFormFieldColorLightTheme,
    onTap: () {
      // Get.to(() => ReportDetails(
      //       data: data,
      //     ));
    },
    leading: CircleAvatar(
      backgroundImage: NetworkImage(reportData['reporter-profile-image-url']),
    ),
    title: Text(reportData['reporter-name']),
    subtitle: Text(
      reportData['report-concern-description'],
      overflow: TextOverflow.ellipsis,
    ),
  );
}
