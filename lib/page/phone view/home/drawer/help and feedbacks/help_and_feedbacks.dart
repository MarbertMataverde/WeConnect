import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:weconnect/controller/controller_help_and_feedback.dart';
import 'package:weconnect/page/phone%20view/home/drawer/help%20and%20feedbacks/help_and_feedbacks_details.dart';
import 'package:weconnect/widgets/appbar/build_appbar.dart';

final Stream<QuerySnapshot> reportStream = FirebaseFirestore.instance
    .collection('help-and-feedback')
    .orderBy('send-at', descending: true)
    .snapshots();

final helpAndFeedbackCtrlr = Get.put(ControllerHelpAndFeedback());

class HelpAndFeedbacks extends StatelessWidget {
  const HelpAndFeedbacks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: 'Help And Feedbacks',
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
              return Card(
                child: Slidable(
                  endActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (_) {
                          helpAndFeedbackCtrlr.removeFeedback(context,
                              assetLocation: 'assets/gifs/question_mark.gif',
                              title: 'Remove Feedback',
                              description:
                                  'Are you sure about removing this feedback?',
                              feedbackId: data.docs[index].id);
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Iconsax.close_square,
                        label: 'Dismiss',
                      ),
                    ],
                  ),
                  child: ListTile(
                    onTap: () => Get.to(() => HelpAndFeedBacksDetails(
                          senderImageUrl: data.docs[index]
                              ['sender-profile-image-url'],
                          senderName: data.docs[index]['sender-name'],
                          senderMessage: data.docs[index]['sender-message'],
                        )),
                    title: Text(
                      data.docs[index]['sender-name'],
                      textScaleFactor: 1.2,
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                      ),
                    ),
                    subtitle: Text(
                      data.docs[index]['sender-message'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
