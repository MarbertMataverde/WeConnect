import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/controller/controller_account_information.dart';
import 'package:weconnect/dialog/dialog_forum.dart';
import 'package:weconnect/widgets/appbar/build_appbar.dart';
import 'package:weconnect/widgets/global%20spinkit/global_spinkit.dart';

import '../../../phone%20view/home/forum/forum_topic_details.dart';
import '../../../phone%20view/home/forum/open_new_topic.dart';

import '../../../../widgets/navigation drawer/widget_navigation_drawer.dart';

final _dialog = Get.put(DialogForum());

class Forum extends StatefulWidget {
  const Forum({
    Key? key,
  }) : super(key: key);

  @override
  State<Forum> createState() => _ForumState();
}

final Stream<QuerySnapshot> _forumTopicStream = FirebaseFirestore.instance
    .collection('forum')
    .doc('approved-request')
    .collection('all-approved-request')
    .orderBy('votes', descending: false)
    .snapshots();

class _ForumState extends State<Forum> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const WidgetNavigationDrawer(),
      appBar: buildAppBar(
        context: context,
        title: 'Forum',
        actions: [
          IconButton(
            tooltip: 'Open New Topic🔥',
            onPressed: () {
              Get.to(() => const OpenNewTopic());
            },
            icon: Icon(
              Iconsax.message_add_1,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          Builder(
            builder: ((context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: Icon(Iconsax.menu,
                    color: Theme.of(context).iconTheme.color),
              );
            }),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _forumTopicStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return buildGlobalSpinkit(context: context);
          }
          final data = snapshot.requireData;
          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              return buildTopicTile(
                context: context,
                topicOwnerName: data.docs[index]['requested-by'],
                topicTitle: data.docs[index]['topic-title'],
                topicVotes: data.docs[index]['votes'],
                topicAcceptedDate: data.docs[index]['request-accepted-at'],
                topicDocId: data.docs[index].id,
                onCliked: () {
                  Get.to(
                    () => ForumTopicDetails(
                      requesterProfileImageUrl: data.docs[index]
                          ['requester-profile-image-url'],
                      requestedBy: data.docs[index]['requested-by'],
                      topicTitle: data.docs[index]['topic-title'],
                      topicDescription: data.docs[index]['topic-description'],
                      topicApprovedDate: data.docs[index]
                          ['request-accepted-at'],
                      topicVotes: data.docs[index]['votes'],
                      topicDocId: data.docs[index].id,
                      requesterUid: data.docs[index]['requester-uid'],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

Widget buildTopicTile({
  required BuildContext context,
  required String topicOwnerName,
  required String topicTitle,
  required List topicVotes,
  required Timestamp topicAcceptedDate,
  VoidCallback? onCliked,
  required String topicDocId,
}) {
  return Card(
    child: InkWell(
      onTap: onCliked,
      borderRadius: BorderRadius.circular(4),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: currentAccountType == 'accountTypeCampusAdmin'
              ? [
                  SlidableAction(
                    onPressed: (_) {},
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Iconsax.trash,
                    label: 'Delete',
                  ),
                ]
              : [
                  SlidableAction(
                    onPressed: (_) {
                      _dialog.reportTopicDialog(
                          context: context, reportDocumentId: topicDocId);
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Iconsax.warning_2,
                    label: 'Report',
                  ),
                ],
        ),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
          title: Text(
            topicTitle,
            textScaleFactor: 1.1,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                topicOwnerName,
                textScaleFactor: 1,
                style: TextStyle(
                  height: 1.2,
                  color: Theme.of(context).textTheme.labelMedium!.color,
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                        text: '${topicVotes.length} ',
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Votes ',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color,
                              )),
                          const TextSpan(
                              text: '❤',
                              style: TextStyle(
                                color: Colors.red,
                              )),
                        ]),
                  ),
                  Text(
                    DateFormat('d MMM yyyy').format(
                      topicAcceptedDate.toDate(),
                    ),
                    textScaleFactor: 0.8,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.labelMedium!.color,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
