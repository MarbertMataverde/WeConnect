import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

//*INITIALIZING FIRESTORE as firestore
final firestore = FirebaseFirestore.instance;

//storage box for storing current uid
final box = GetStorage();

class AccountType extends GetxController {
  Future getter() async {
    final _currentUid = box.read('currentUid');
    accountTypeIdentifier(
      //campus admin
      'campus-admin',
      _currentUid,
      'accountTypeCampusAdmin',
    );
    accountTypeIdentifier(
      //coa admin
      'coa-admin',
      _currentUid,
      'accountTypeCoaAdmin',
    );
    accountTypeIdentifier(
      //cob admin
      'cob-admin',
      _currentUid,
      'accountTypeCobAdmin',
    );
    accountTypeIdentifier(
      //ccs admin
      'ccs-admin',
      _currentUid,
      'accountTypeCssAdmin',
    );
    accountTypeIdentifier(
      //masteral admin
      'masteral-admin',
      _currentUid,
      'accountTypeMasteralAdmin',
    );
    accountTypeIdentifier(
      //professor
      'professors',
      _currentUid,
      'accountTypeProfessor',
    );
    accountTypeIdentifier(
      //student
      'students',
      _currentUid,
      'accountTypeStudent',
    );
  }

  Future accountTypeIdentifier(
    String doc,
    String currentUid,
    String accountType,
  ) async {
    //shared preferences initialization
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await firestore
        .collection('accounts')
        .doc(doc)
        .collection('account')
        .doc(currentUid)
        .get()
        .then(
      (value) async {
        if (value.exists) {
          await sharedPreferences.setString('accountType', accountType);
        }
      },
    );
  }
}
