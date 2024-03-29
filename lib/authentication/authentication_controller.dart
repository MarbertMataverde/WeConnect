import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/constant.dart';
import '../controller/controller_account_information.dart';
import '../dialog/dialog_authentication.dart';
import '../page/phone view/home/home_phone_wrapper.dart';
import '../page/phone view/sign in/phone_view.dart';
import '../page/web view/sign in/web_view.dart';

//*INITIALIZING FIRESTORE as firestore
final firestore = FirebaseFirestore.instance;

//initializing firebase auth as _auth
final FirebaseAuth _auth = FirebaseAuth.instance;

//get storage box
final box = GetStorage();

//getting account type
final accountInformation = Get.put(ControllerAccountInformation());

//dialogs
final dialog = Get.put(DialogAuthentication());

class Authentication extends GetxController {
  //sign in
  Future<void> signIn(String emailAddress, String password, context) async {
    //shared preferences initialization
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      await _auth
          .signInWithEmailAndPassword(email: emailAddress, password: password)
          .then(
        (UserCredential value) async {
          // if (value.user!.emailVerified) {
          //   //this will make sure that the current user id is not null
          //   await sharedPreferences.setString('currentUid', value.user!.uid);
          //   await sharedPreferences.setString(
          //       'signInToken', value.user!.email as String);
          //   await accountInformation
          //       .getter(sharedPreferences.get('currentUid') as String);
          // } else {
          //   dialog.emailNotVerified(
          //       context: context,
          //       assetLocation: 'assets/gifs/warning.gif',
          //       title: 'Not Verified Account',
          //       description: 'Please check your mail to verify your account');
          // }
          //this will make sure that the current user id is not null
          await sharedPreferences.setString('currentUid', value.user!.uid);
          await sharedPreferences.setString(
              'signInToken', value.user!.email as String);
          await accountInformation
              .getter(sharedPreferences.get('currentUid') as String);
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        dialog.userNotFoundDialog(
            context,
            'assets/gifs/user_not_found.gif',
            'User Not Found 😕',
            'We can\'t find your account please make sure your credential is correct and try again 😊');
      } else if (e.code == 'wrong-password') {
        dialog.incorrectPasswordDialog(
            context,
            'assets/gifs/incorrect_password.gif',
            'Incorrect Password 🤔',
            'Please make sure your password is correct ✔ 😉');
      }
    } catch (e) {
      dialog.somethingWentWrongDialog(
          context,
          'assets/gifs/something_went_wrong.gif',
          'Someting Went Wrong 😕',
          'Please restart the app or contact tech support 👨🏻‍💻');
    }
  }

  //sign up new student account
  Future<void> studentSignUp(
    String accessCode,
    String fullName,
    String college,
    int studentNumber,
    String emailAddress,
    String password,
    context,
  ) async {
    //shared preferences initialization
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: emailAddress, password: password)
          .then((value) async {
        firestore
            .collection('accounts')
            .doc('students')
            .collection('account')
            .doc(_auth.currentUser!.uid)
            .set({
          'regs-access-code': accessCode,
          'account-tpye': 'studentAccountInformation',
          'profile-name': fullName,
          'college': college,
          'student-number': studentNumber,
          'profile-image-url': kDefaultProfile,
          'profile-email': emailAddress,
          'channels': [],
        }).whenComplete(() async {
          firestore.collection('student-access-code').doc(accessCode).delete();
          //getting account information
          Get.offAll(() => const HomePhoneWrapper());
          //email verification
          await _auth.currentUser?.sendEmailVerification();
        });
        //this will make sure that the current user id is not null
        await sharedPreferences.setString('currentUid', value.user!.uid);
        //getting account information
        await accountInformation
            .getter(sharedPreferences.get('currentUid') as String);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {
        dialog.emailAlreadyInUseDialog(
            context,
            'assets/gifs/exsisting_account_found.gif',
            'Email Already In Use',
            'If you forgot your password you can change it now by clicking the reset button'); // student
      }
    } catch (e) {
      dialog.somethingWentWrongDialog(
          context,
          'assets/gifs/something_went_wrong.gif',
          'Someting Went Wrong 😕',
          'Please restart the app or contact tech support 👨🏻‍💻');
    }
  }

  //sign up new professor account
  Future<void> professorSignUp(
    String accessCode,
    String fullName,
    int contactNumber,
    int employeeNumber,
    String emailAddress,
    String password,
    context,
  ) async {
    //shared preferences initialization
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: emailAddress, password: password)
          .then((value) async {
        firestore
            .collection('accounts')
            .doc('professors')
            .collection('account')
            .doc(_auth.currentUser!.uid)
            .set({
          'regs-access-code': accessCode,
          'account-tpye': 'professorAccountInformation',
          'profile-image-url': kDefaultProfile,
          'profile-name': fullName,
          'contact-number': contactNumber,
          'employee-number': employeeNumber,
          'profile-email': emailAddress,
          'channels': [],
        }).whenComplete(() async {
          firestore
              .collection('professor-access-code')
              .doc(accessCode)
              .delete();
          //getting account information
          Get.offAll(() => const HomePhoneWrapper());
          //email verification
          await _auth.currentUser?.sendEmailVerification();
        });
        //this will make sure that the current user id is not null
        await sharedPreferences.setString('currentUid', value.user!.uid);
        //getting account information
        await accountInformation
            .getter(sharedPreferences.get('currentUid') as String);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {
        dialog.emailAlreadyInUseDialog(
            context,
            'assets/gifs/exsisting_account_found.gif',
            'Email Already In Use',
            'If you forgot your password you can change it now by clicking the reset button'); // student
      }
    } catch (e) {
      dialog.somethingWentWrongDialog(
          context,
          'assets/gifs/something_went_wrong.gif',
          'Someting Went Wrong 😕',
          'Please restart the app or contact tech support 👨🏻‍💻');
    }
  }

  // reset password
  Future<void> resetPassword(String email, context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email).whenComplete(() =>
          dialog.resetPasswordDialog(context, 'assets/gifs/email_sent.gif',
              'Mail Sent 💌', 'We have e-mailed your password reset link! 🤗'));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {}
    } catch (e) {
      dialog.somethingWentWrongDialog(
          context,
          'assets/gifs/something_went_wrong.gif',
          'Someting Went Wrong 😕',
          'Please restart the app or contact tech support 👨🏻‍💻');
    }
  }

  //signedout
  Future<void> signOut() async {
    _auth.signOut();
    //shared preferences initialization
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    await box.erase();
    Get.offAll(() => kIsWeb ? const WebView() : const PhoneViewSignIn());
  }
}
