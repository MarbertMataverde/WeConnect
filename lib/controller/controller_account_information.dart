import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dialog/dialog_authentication.dart';
import '../page/phone view/home/home_phone_wrapper.dart';
import '../page/web view/home/home_web_wrapper.dart';

//*INITIALIZING FIRESTORE as firestore
final firestore = FirebaseFirestore.instance;

//storage box for storing current uid
final box = GetStorage();

//dialogs
final dialogs = Get.put(DialogAuthentication());

class ControllerAccountInformation extends GetxController {
  Future getter(String _currentUid) async {
    accountTypeIdentifier(
      //campus admin
      'campus-admin',
      _currentUid,
      'accountTypeCampusAdmin',
    );
    accountTypeIdentifier(
      //registrar admin
      'registrar-admin',
      _currentUid,
      'accountTypeRegistrarAdmin',
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
      'accountTypeCcsAdmin',
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
    await firestore
        .collection('accounts')
        .doc(doc)
        .collection('account')
        .doc(currentUid)
        .get()
        .then(
      (value) async {
        if (value.exists) {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          await sharedPreferences.setString('accountType', accountType);
          await sharedPreferences.setString(
              'currentProfileImageUrl', value.get('profile-image-url'));
          await sharedPreferences.setString(
              'currentProfileName', value.get('profile-name'));
          if (sharedPreferences.get('accountType') == 'accountTypeStudent') {
            await sharedPreferences.setString(
                'studentCollege', value.get('college'));
          }
          //routing
          if (kIsWeb) {
            if (sharedPreferences.get('accountType') ==
                'accountTypeCampusAdmin') {
              Get.off(() => const HomeWebWrapper());
            } else {
              dialogs.invalidAccountTypeDialog(
                Get.context,
                'assets/gifs/invalid_account_type.gif',
                'Invalid Account Type',
                'Please do sign-in to our WeConnect Mobile Application 📱',
              );
            }
          } else {
            Get.off(() => const HomePhoneWrapper());
          }
        }
      },
    );
  }
}
