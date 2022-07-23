import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:universal_html/html.dart' show AnchorElement;

final firestore = FirebaseFirestore.instance;

//*ACCESS CODE TRACKER
String generatedAccessCodeTracker = '';
//*RANDOM CHARACTER GENERATOR
const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();
String getRandomString(int length) => String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => _chars.codeUnitAt(
          _rnd.nextInt(_chars.length),
        ),
      ),
    );

class XlsxAccessCodeGenerator extends GetxController {
  Future<void> createAccessCodeExcelFile(
    String collectionName,
    String accessCodeController,
    String fileName,
  ) async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    for (var i = 0; i < int.parse(accessCodeController); i++) {
      // this will track the current generated access code
      generatedAccessCodeTracker = getRandomString(9);
      //this will put each generated access code to our firestore database
      //as document so that we can easily check the access code if existing or not
      firestore
          .collection(collectionName)
          .doc(generatedAccessCodeTracker)
          .set({});
      //adding each generated access code to excel sheet row by row
      sheet.getRangeByName('A${i + 1}').setText(generatedAccessCodeTracker);
    }
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    //this is responsible for the excel file to automaticaly downloaded to downloads
    // directory in user machine
    AnchorElement(
        href:
            'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
      ..setAttribute('download', '$fileName.xlsx')
      ..click();
  }
}
