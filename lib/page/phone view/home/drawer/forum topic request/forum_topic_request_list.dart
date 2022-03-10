import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../../dialog/dialog_forum.dart';
import '../../../../phone%20view/home/drawer/forum%20topic%20request/detailed_topic_request.dart';

import '../../../../../constant/constant_colors.dart';
import '../../../../../widgets/appbar title/appbar_title.dart';

class ForumTopicRequestList extends StatefulWidget {
  const ForumTopicRequestList({Key? key}) : super(key: key);

  @override
  State<ForumTopicRequestList> createState() => _ForumTopicRequestListState();
}

class _ForumTopicRequestListState extends State<ForumTopicRequestList> {
  final DialogForum forum = Get.put(DialogForum());
  //forum topic request stream
  final Stream<QuerySnapshot> topicRequestStream = FirebaseFirestore.instance
      .collection('forum')
      .doc('topic-request')
      .collection('all-request')
      .orderBy('requested-at', descending: false)
      .snapshots();
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
          title: 'Topic Request',
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: topicRequestStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return SpinKitSpinningLines(color: Get.theme.primaryColor);
          }
          final data = snapshot.requireData;
          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              Timestamp reportedAt = data.docs[index]['requested-at'];
              return Slidable(
                endActionPane: ActionPane(
                  motion: const StretchMotion(),
                  dragDismissible: true,
                  children: [
                    SlidableAction(
                      onPressed: (_) {
                        forum.requestApprovalDialog(context,
                            assetLocation: 'assets/gifs/question_mark.gif',
                            title: 'Request Approval',
                            description:
                                'Are you sure about approving this topic request?',
                            requestedBy: data.docs[index]['requested-by'],
                            requesterProfileImageUrl: data.docs[index]
                                ['requester-profile-image-url'],
                            requesterUid: data.docs[index]['requester-uid'],
                            topicTitle: data.docs[index]['topic-title'],
                            topicDescription: data.docs[index]
                                ['topic-description'],
                            requestDocId: data.docs[index].id);
                      },
                      backgroundColor: Get.theme.primaryColor,
                      foregroundColor: Colors.white,
                      icon: MdiIcons.publish,
                      label: 'Publish',
                    ),
                    SlidableAction(
                      onPressed: (_) {
                        forum.dismissRequestDialog(
                          context,
                          assetLocation: 'assets/gifs/question_mark.gif',
                          title: 'Request Dismissal',
                          description:
                              'Are you sure about dismissing this request?',
                          requestDocId: data.docs[index].id,
                        );
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.remove_circle_outline,
                      label: 'Dismiss',
                    ),
                  ],
                ),
                child: ListTile(
                  onTap: () {
                    Get.to(
                      () => RequestDetails(
                        requesterProfileImageUrl: data.docs[index]
                            ['requester-profile-image-url'],
                        requestedBy: data.docs[index]['requested-by'],
                        requestedAt: data.docs[index]['requested-at'],
                        requesterUid: data.docs[index]['requester-uid'],
                        topicTitle: data.docs[index]['topic-title'],
                        topicDescription: data.docs[index]['topic-description'],
                        //request dismissal
                        requestDocId: data.docs[index].id,
                      ),
                    );
                  },
                  tileColor: Get.isDarkMode
                      ? kTextFormFieldColorDarkTheme
                      : kTextFormFieldColorLightTheme,
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        data.docs[index]['requester-profile-image-url']),
                  ),
                  title: Text(data.docs[index]['requested-by']),
                  subtitle: Text(
                    data.docs[index]['topic-title'],
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Text(
                      timeago.format(reportedAt.toDate(), locale: 'en_short')),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
