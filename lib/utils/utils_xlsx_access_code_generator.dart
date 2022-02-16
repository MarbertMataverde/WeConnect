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
    String _collectionName,
    String _accessCodeController,
    String _fileName,
  ) async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    for (var i = 0; i < int.parse(_accessCodeController); i++) {
      // this will track the current generated access code
      generatedAccessCodeTracker = getRandomString(9);
      firestore
          .collection(_collectionName)
          .doc(generatedAccessCodeTracker)
          .set({});
      sheet.getRangeByName('A${i + 1}').setText(generatedAccessCodeTracker);
    }
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    AnchorElement(
        href:
            'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
      ..setAttribute('download', '$_fileName.xlsx')
      ..click();
  }
}
