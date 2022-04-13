import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../constant/constant_forms_url.dart';

import '../../../../../widgets/appbar/build_appbar.dart';

class DownloadForms extends StatelessWidget {
  const DownloadForms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: 'Forms',
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
      body: Padding(
        padding: EdgeInsets.all(5.w),
        child: ListView(
          children: [
            _buildTitle(aboutTitle: 'Application for Admission Forms'),
            const Divider(),
            _buildDOwnloadFormListTile(
                context: context,
                title: 'Senior High School',
                url: kSeniorHighSchool),
            _buildDOwnloadFormListTile(
                context: context,
                title: 'Undergraduate (College)',
                url: kUndergraduateCollege),
            _buildDOwnloadFormListTile(
                context: context,
                title: 'Graduate School',
                url: kGraduateSchool),
            _buildDOwnloadFormListTile(
                context: context,
                title: 'Foreign Students',
                url: kForeignStudents),
            //
            _buildTitle(aboutTitle: 'Free Tuition Fee Forms'),
            const Divider(),
            _buildDOwnloadFormListTile(
                context: context,
                title: 'Free Tuition Fee Pre-registration form',
                url: kFreeTuitionFeePreRegistrationform),
            _buildDOwnloadFormListTile(
                context: context,
                title: 'Free Tuition Fee form (Registrar’s Copy)',
                url: kFreeTuitionFeeformRegistrarsCopy),
            _buildDOwnloadFormListTile(
                context: context,
                title: 'Free Tuition Fee form (OSDS’s Copy)',
                url: kFreeTuitionFeeformOSDSsCopy),
            //
            _buildTitle(aboutTitle: 'Graduate School Forms'),
            const Divider(),
            _buildDOwnloadFormListTile(
                context: context,
                title: 'Application for Registration',
                url: kApplicationforRegistration),
            _buildDOwnloadFormListTile(
                context: context,
                title: 'Application for Proposal Defense',
                url: kApplicationforProposalDefense),
            _buildDOwnloadFormListTile(
                context: context,
                title: 'Application for Final Oral Defense',
                url: kApplicationforFinalOralDefense),
            //
            _buildTitle(aboutTitle: 'Other Forms'),
            const Divider(),
            _buildDOwnloadFormListTile(
                context: context,
                title: 'Completion form',
                url: kCompletionform),
            _buildDOwnloadFormListTile(
                context: context,
                title: 'Dropping and Adding form',
                url: kDroppingandAddingform),
            _buildDOwnloadFormListTile(
                context: context,
                title: 'Request and Claim Slip',
                url: kRequestandClaimSlip),
            _buildDOwnloadFormListTile(
                context: context,
                title: 'Self Liquidating Program form (SLP)',
                url: kSelfLiquidatingProgramformSLP),
            _buildDOwnloadFormListTile(
                context: context, title: 'Shifting form', url: kShiftingform),
            _buildDOwnloadFormListTile(
                context: context,
                title: 'Students Clearance',
                url: kStudentsClearance),
            _buildDOwnloadFormListTile(
                context: context,
                title: 'Waiver for non-compliance of grades',
                url: kWaiverForNonComplianceOfGrades),
            _buildDOwnloadFormListTile(
                context: context,
                title: 'Application for graduation form',
                url: kApplicationforgraduationform),
            _buildDOwnloadFormListTile(
                context: context,
                title: 'Medical Record Form',
                url: kMedicalRecordForm),
            _buildDOwnloadFormListTile(
                context: context,
                title: 'Individual Dental Health Record Form',
                url: kIndividualDentalHealthRecordForm),
            _buildDOwnloadFormListTile(
                context: context,
                title: 'Student Information Sheet',
                url: kStudentInformationSheet),
          ],
        ),
      ),
    );
  }
}

Widget _buildTitle({
  required String aboutTitle,
}) {
  return Text(
    aboutTitle,
    textScaleFactor: 1.3,
    style: const TextStyle(
      fontWeight: FontWeight.w600,
    ),
  );
}

Widget _buildDOwnloadFormListTile({
  required String title,
  required String url,
  required BuildContext context,
}) {
  return ListTile(
    title: Text(
      title,
      style: TextStyle(
        color: Theme.of(context).textTheme.labelMedium!.color,
      ),
    ),
    trailing: IconButton(
      splashRadius: 3.h,
      onPressed: () => openBroweserUrl(url: url),
      icon: Icon(
        Iconsax.document_download,
        color: Theme.of(context).primaryColor,
      ),
    ),
  );
}

Future openBrowserURL({
  required String url,
  bool inApp = true,
}) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: inApp, // ios
      forceWebView: inApp, // android
      enableJavaScript: true, // android
    );
  }
}

Future openBroweserUrl({
  required String url,
  bool inApp = false,
}) async {
  if (await canLaunch(url)) {
    await launch(url,
        forceSafariVC: inApp, // ios
        forceWebView: inApp, //android
        enableJavaScript: true //android
        );
  }
}
