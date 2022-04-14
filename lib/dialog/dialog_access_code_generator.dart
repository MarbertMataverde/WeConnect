import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giff_dialog/giff_dialog.dart';

import '../utils/utils_xlsx_access_code_generator.dart';

final xlsxAccessCodeGenerator = Get.put(XlsxAccessCodeGenerator());

class DialogAccessCodeGenerator extends GetxController {
  //access code geneation confirmation dialog
  Future<dynamic> accessCodeConfirmationDialog(
    context, {
    required String assetLocation,
    required String title,
    required String description,
    //saving information
    required String collectionName,
    required String studentAxCodeCtrlr,
    required String studentAccessCodeFileName,
  }) async {
    showDialog(
      context: context,
      builder: (_) => AssetGiffDialog(
        buttonOkColor: Theme.of(context).primaryColor,
        image: Image.asset(
          assetLocation,
          fit: BoxFit.cover,
        ),
        entryAnimation: EntryAnimation.bottom,
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
        ),
        description: Text(
          description,
          textAlign: TextAlign.center,
        ),
        onOkButtonPressed: () async {
          await xlsxAccessCodeGenerator.createAccessCodeExcelFile(
            collectionName,
            studentAxCodeCtrlr,
            studentAccessCodeFileName,
          );
        },
      ),
    );
  }
}
