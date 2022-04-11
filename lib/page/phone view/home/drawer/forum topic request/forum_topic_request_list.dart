import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:weconnect/widgets/appbar/build_appbar.dart';
import '../../../../../dialog/dialog_forum.dart';
import '../../../../phone%20view/home/drawer/forum%20topic%20request/detailed_topic_request.dart';

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
      appBar: buildAppBar(
        context: context,
        title: 'Forum Request',
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Iconsax.arrow_square_left,
              color: Theme.of(context).iconTheme.color,
            )),
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
              return Card(
                child: Slidable(
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
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        icon: Iconsax.tick_square,
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
                        icon: Iconsax.close_square,
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
                          topicDescription: data.docs[index]
                              ['topic-description'],
                          //request dismissal
                          requestDocId: data.docs[index].id,
                        ),
                      );
                    },
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(5.w),
                      child: Image.network(
                        data.docs[index]['requester-profile-image-url'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      data.docs[index]['requested-by'],
                      textScaleFactor: 1.1,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      data.docs[index]['topic-title'],
                      overflow: TextOverflow.ellipsis,
                      textScaleFactor: 0.9,
                      style: TextStyle(
                        height: 1.2,
                        color: Theme.of(context).textTheme.labelMedium!.color,
                      ),
                    ),
                    trailing: Text(
                      timeago.format(reportedAt.toDate(), locale: 'en_short'),
                    ),
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
