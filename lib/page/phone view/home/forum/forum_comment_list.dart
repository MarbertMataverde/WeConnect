import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weconnect/widgets/appbar/build_appbar.dart';
import 'package:weconnect/widgets/global%20spinkit/global_spinkit.dart';
import '../../../../controller/controller_forum.dart';
import '../../../../widgets/appbar/appbar_title.dart';
import '../../../../widgets/comment/comment_tile.dart';
import '../../../../controller/controller_account_information.dart';
import '../../../../widgets/comment/comment_form.dart';

class ForumCommentList extends StatefulWidget {
  const ForumCommentList({
    Key? key,
    required this.topicDocId,
  }) : super(key: key);

  final String topicDocId;

  @override
  State<ForumCommentList> createState() => ForumCommentListState();
}

class ForumCommentListState extends State<ForumCommentList> {
  final TextEditingController topicCommentCtrl = TextEditingController();

  final ControllerForum forum = Get.put(ControllerForum());

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> commentsStream = FirebaseFirestore.instance
        .collection('forum')
        .doc('approved-request')
        .collection('all-approved-request')
        .doc(widget.topicDocId)
        .collection('topic-comments')
        .orderBy('commented-date', descending: true)
        .snapshots();
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: 'Comments',
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Iconsax.arrow_square_left,
              color: Theme.of(context).iconTheme.color,
            )),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: commentsStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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
                    return buildCommentTile(
                      context: context,
                      profileName: data.docs[index]['commenter-profile-name'],
                      profileImageUrl: data.docs[index]
                          ['commenter-profile-image-url'],
                      comment: data.docs[index]['commenter-comment'],
                      commentedDate: data.docs[index]['commented-date'],
                    );
                  },
                );
              },
            ),
          ),
          buildCommentForm(
              context: context,
              formKey: _formKey,
              onSend: () async {
                final _isValid = _formKey.currentState!.validate();

                if (_isValid == true) {
                  await forum.addTopicComment(
                    commenterComment: topicCommentCtrl.text,
                    commenterProfileImageUrl: currentProfileImageUrl.toString(),
                    commenterProfileName: currentProfileName.toString(),
                    topicDocId: widget.topicDocId,
                  );
                  topicCommentCtrl.clear();
                  Get.focusScope!.unfocus();
                }
              },
              textEditingCtrlr: topicCommentCtrl),
        ],
      ),
    );
  }
}
