import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weconnect/dialog/dialog_authentication.dart';

import '../constant/constant.dart';
import '../controller/controller_account_information.dart';
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
  Future<void> signIn(String _emailAddress, String _password, _context) async {
    //shared preferences initialization
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      await _auth
          .signInWithEmailAndPassword(email: _emailAddress, password: _password)
          .then((UserCredential value) async {
        //getting current uid
        box.write('currentUid', value.user!.uid);
        //getting account type
        sharedPreferences.setString('currentUid', value.user!.uid);
        //getting account information
        await sharedPreferences.setString('currentUid', value.user!.uid);
        //writing data to sharedPreference
        await sharedPreferences.setString(
            'signInToken', value.user!.email as String);
        await accountInformation
            .getter(sharedPreferences.get('currentUid') as String);
      });
      // accountInformation.getter();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        dialog.userNotFoundDialog(
            _context,
            'assets/gifs/user_not_found.gif',
            'User Not Found 😕',
            'We can\'t find your account please make sure your credential is correct and try again 😊');
      } else if (e.code == 'wrong-password') {
        dialog.incorrectPasswordDialog(
            _context,
            'assets/gifs/incorrect_password.gif',
            'Incorrect Password 🤔',
            'Please make sure your password is correct ✔ 😉');
      }
    } catch (e) {
      dialog.somethingWentWrongDialog(
          _context,
          'assets/gifs/something_went_wrong.gif',
          'Someting Went Wrong 😕',
          'Please restart the app or contact tech support 👨🏻‍💻');
    }
  }

  //sign up new student account
  Future<void> studentSignUp(
    String _accessCode,
    String _fullName,
    String _college,
    int _studentNumber,
    String _emailAddress,
    String _password,
    _context,
  ) async {
    //shared preferences initialization
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: _emailAddress, password: _password)
          .then((value) async {
        firestore
            .collection('accounts')
            .doc('students')
            .collection('account')
            .doc(_auth.currentUser!.uid)
            .set({
          'regs-access-code': _accessCode,
          'account-tpye': 'studentAccountInformation',
          'profile-name': _fullName,
          'college': _college,
          'student-number': _studentNumber,
          'profile-image-url': kDefaultProfile,
          'profile-email': _emailAddress,
          'channels': [],
        }).whenComplete(() {
          firestore.collection('student-access-code').doc(_accessCode).delete();
          //getting account information
          Get.offAll(() => const HomePhoneWrapper());
        });
        //getting account information
        await sharedPreferences.setString('currentUid', value.user!.uid);
        accountInformation
            .getter(sharedPreferences.get('currentUid') as String);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {
        dialog.emailAlreadyInUseDialog(
            _context,
            'assets/gifs/exsisting_account_found.gif',
            'Email Already In Use 🤨',
            'Your email is already in use 🤔 \nIf you forgot your password you can change it now by clicking the reset button 😉'); // student
      }
    } catch (e) {
      dialog.somethingWentWrongDialog(
          _context,
          'assets/gifs/something_went_wrong.gif',
          'Someting Went Wrong 😕',
          'Please restart the app or contact tech support 👨🏻‍💻');
    }
  }

  //sign up new professor account
  Future<void> professorSignUp(
    String _accessCode,
    String _fullName,
    int _contactNumber,
    int _employeeNumber,
    String _emailAddress,
    String _password,
    _context,
  ) async {
    //shared preferences initialization
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: _emailAddress, password: _password)
          .then((value) async {
        firestore
            .collection('accounts')
            .doc('professors')
            .collection('account')
            .doc(_auth.currentUser!.uid)
            .set({
          'regs-access-code': _accessCode,
          'account-tpye': 'professorAccountInformation',
          'profile-image-url': kDefaultProfile,
          'profile-name': _fullName,
          'contact-number': _contactNumber,
          'employee-number': _employeeNumber,
          'profile-email': _emailAddress,
          'channels': [],
        }).whenComplete(() {
          firestore
              .collection('professor-access-code')
              .doc(_accessCode)
              .delete();
          //getting account information
          Get.offAll(() => const HomePhoneWrapper());
        });
        //getting account information
        await sharedPreferences.setString('currentUid', value.user!.uid);
        accountInformation
            .getter(sharedPreferences.get('currentUid') as String);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {
        dialog.emailAlreadyInUseDialog(
            _context,
            'assets/gifs/exsisting_account_found.gif',
            'Email Already In Use 🤨',
            'Your email is already in use 🤔 \nIf you forgot your password you can change it now by clicking the reset button 😉'); // student
      }
    } catch (e) {
      dialog.somethingWentWrongDialog(
          _context,
          'assets/gifs/something_went_wrong.gif',
          'Someting Went Wrong 😕',
          'Please restart the app or contact tech support 👨🏻‍💻');
    }
  }

  // reset password
  Future<void> resetPassword(String _email, _context) async {
    try {
      await _auth.sendPasswordResetEmail(email: _email).whenComplete(() =>
          dialog.resetPasswordDialog(_context, 'assets/gifs/email_sent.gif',
              'Mail Sent 💌', 'We have e-mailed your password reset link! 🤗'));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {}
    } catch (e) {
      dialog.somethingWentWrongDialog(
          _context,
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
    Get.off(() => kIsWeb ? const WebView() : const PhoneViewSignIn());
  }
}
