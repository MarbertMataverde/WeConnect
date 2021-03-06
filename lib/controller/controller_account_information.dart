import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show debugPrint, kIsWeb;
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
String? currentAccountType;
String? currentStudentCollege;
String? currentProfileName;
String? currentProfileImageUrl;
String? currentUserId;
bool? isSignedIn;
String? userThemePreference = 'light'; // default  light

class ControllerAccountInformation extends GetxController {
  Future getter(String currentUid) async {
    accountTypeIdentifier(
      //campus admin
      'campus-admin',
      currentUid,
      'accountTypeCampusAdmin',
    );
    accountTypeIdentifier(
      //registrar admin
      'registrar-admin',
      currentUid,
      'accountTypeRegistrarAdmin',
    );
    accountTypeIdentifier(
      //coa admin
      'coa-admin',
      currentUid,
      'accountTypeCoaAdmin',
    );
    accountTypeIdentifier(
      //cob admin
      'cob-admin',
      currentUid,
      'accountTypeCobAdmin',
    );
    accountTypeIdentifier(
      //ccs admin
      'ccs-admin',
      currentUid,
      'accountTypeCcsAdmin',
    );
    accountTypeIdentifier(
      //masteral admin
      'masteral-admin',
      currentUid,
      'accountTypeMasteralAdmin',
    );
    accountTypeIdentifier(
      //professor
      'professors',
      currentUid,
      'accountTypeProfessor',
    );
    accountTypeIdentifier(
      //student
      'students',
      currentUid,
      'accountTypeStudent',
    );
  }

  Future accountTypeIdentifier(
    String doc,
    String currentUid,
    String accountType,
  ) async {
    try {
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
            //writing data to sharedPreference
            await sharedPreferences.setBool('isSignedIn', true);
            isSignedIn = sharedPreferences.getBool('isSignedIn');
            currentUserId = sharedPreferences.get('currentUid').toString();
            await sharedPreferences.setString('accountType', accountType);
            currentAccountType =
                sharedPreferences.get('accountType').toString();
            await sharedPreferences.setString(
                'currentProfileImageUrl', value.get('profile-image-url'));
            currentProfileImageUrl =
                sharedPreferences.get('currentProfileImageUrl').toString();
            await sharedPreferences.setString(
                'currentProfileName', value.get('profile-name'));
            currentProfileName =
                sharedPreferences.get('currentProfileName').toString();

            if (sharedPreferences.get('accountType') == 'accountTypeStudent') {
              await sharedPreferences.setString(
                  'studentCollege', value.get('college'));
              currentStudentCollege =
                  sharedPreferences.get('studentCollege').toString();
            }
            //routing
            if (kIsWeb) {
              if (currentAccountType == 'accountTypeCampusAdmin') {
                Get.offAll(
                  () => const HomeWebWrapper(),
                  transition: Transition.noTransition,
                );
              } else {
                dialogs.invalidAccountTypeDialog(
                  Get.context,
                  'assets/gifs/invalid_account_type.gif',
                  'Invalid Account Type',
                  'Please do sign-in to our WeConnect Mobile Application ????',
                );
              }
            } else {
              Get.off(
                () => const HomePhoneWrapper(),
                transition: Transition.noTransition,
              );
            }
          }
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
