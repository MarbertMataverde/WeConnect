import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weconnect/constant/constant_colors.dart';
import 'package:weconnect/constant/constant_forms_url.dart';

import '../../../../../widgets/appbar/appbar_title.dart';

class DownloadForms extends StatelessWidget {
  const DownloadForms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const AppBarTitle(title: 'Forms'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(5.w),
        child: ListView(
          children: [
            _buildTitle(aboutTitle: 'Application for Admission Forms'),
            const Divider(),
            _buildDOwnloadFormListTile(
                title: 'Senior High School', url: kSeniorHighSchool),
            _buildDOwnloadFormListTile(
                title: 'Undergraduate (College)', url: kUndergraduateCollege),
            _buildDOwnloadFormListTile(
                title: 'Graduate School', url: kGraduateSchool),
            _buildDOwnloadFormListTile(
                title: 'Foreign Students', url: kForeignStudents),
            //
            _buildTitle(aboutTitle: 'Free Tuition Fee Forms'),
            const Divider(),
            _buildDOwnloadFormListTile(
                title: 'Free Tuition Fee Pre-registration form',
                url: kFreeTuitionFeePreRegistrationform),
            _buildDOwnloadFormListTile(
                title: 'Free Tuition Fee form (Registrar’s Copy)',
                url: kFreeTuitionFeeformRegistrarsCopy),
            _buildDOwnloadFormListTile(
                title: 'Free Tuition Fee form (OSDS’s Copy)',
                url: kFreeTuitionFeeformOSDSsCopy),
            //
            _buildTitle(aboutTitle: 'Graduate School Forms'),
            const Divider(),
            _buildDOwnloadFormListTile(
                title: 'Application for Registration',
                url: kApplicationforRegistration),
            _buildDOwnloadFormListTile(
                title: 'Application for Proposal Defense',
                url: kApplicationforProposalDefense),
            _buildDOwnloadFormListTile(
                title: 'Application for Final Oral Defense',
                url: kApplicationforFinalOralDefense),
            //
            _buildTitle(aboutTitle: 'Other Forms'),
            const Divider(),
            _buildDOwnloadFormListTile(
                title: 'Completion form', url: kCompletionform),
            _buildDOwnloadFormListTile(
                title: 'Dropping and Adding form', url: kDroppingandAddingform),
            _buildDOwnloadFormListTile(
                title: 'Request and Claim Slip', url: kRequestandClaimSlip),
            _buildDOwnloadFormListTile(
                title: 'Self Liquidating Program form (SLP)',
                url: kSelfLiquidatingProgramformSLP),
            _buildDOwnloadFormListTile(
                title: 'Shifting form', url: kShiftingform),
            _buildDOwnloadFormListTile(
                title: 'Students Clearance', url: kStudentsClearance),
            _buildDOwnloadFormListTile(
                title: 'Waiver for non-compliance of grades',
                url: kWaiverForNonComplianceOfGrades),
            _buildDOwnloadFormListTile(
                title: 'Application for graduation form',
                url: kApplicationforgraduationform),
            _buildDOwnloadFormListTile(
                title: 'Medical Record Form', url: kMedicalRecordForm),
            _buildDOwnloadFormListTile(
                title: 'Individual Dental Health Record Form',
                url: kIndividualDentalHealthRecordForm),
            _buildDOwnloadFormListTile(
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
    style: TextStyle(
      color: Get.isDarkMode ? kTextColorDarkTheme : kTextColorLightTheme,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget _buildDOwnloadFormListTile({
  required String title,
  required String url,
}) {
  return ListTile(
    title: Text(
      title,
      style: TextStyle(
        color: Get.isDarkMode ? kTextColorDarkTheme : kTextColorLightTheme,
      ),
    ),
    trailing: IconButton(
      onPressed: () => openBroweserUrl(url: url),
      icon: Icon(
        MdiIcons.fileDownloadOutline,
        color: Get.theme.primaryColor,
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
