import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weconnect/constant/constant_colors.dart';
import 'package:weconnect/views/phone%20view/forgot%20password/forgot_password.dart';
import 'package:weconnect/views/phone%20view/sign%20in/phone_view.dart';
import 'package:weconnect/views/web%20view/home/home_student_axcode.dart';
import 'package:weconnect/views/web%20view/sign%20in/web_view.dart';

import '../constant/constant.dart';
import '../views/phone view/home/main feed/main_feed.dart';

//*INITIALIZING FIRESTORE as firestore
final firestore = FirebaseFirestore.instance;

//initializing firebase auth as _auth
final FirebaseAuth _auth = FirebaseAuth.instance;

class Authentication extends GetxController {
  //sign in
  Future<void> signIn(String _emailAddress, String _password, _context) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: _emailAddress, password: _password)
          .then((value) async {
        //shared preferences initialization
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        //writing data to sharedPreference
        await sharedPreferences.setString(
            'signInToken', value.user!.email as String);
        kIsWeb
            ? Get.off(() => const StudentAxCodeGenerator())
            : Get.off(() => const MainFeed());
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(
          context: _context,
          builder: (_) => AssetGiffDialog(
            onlyOkButton: true,
            buttonOkColor: Get.theme.primaryColor,
            image: Image.asset(
              'assets/gifs/user_not_found.gif',
              fit: BoxFit.cover,
            ),
            entryAnimation: EntryAnimation.bottom,
            title: const Text(
              'User Not Found 😕',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
            description: const Text(
              'We can\'t find your account please make sure your credential is correct and try again 😊',
              textAlign: TextAlign.center,
            ),
            onOkButtonPressed: () {
              Get.back();
            },
          ),
        );
      } else if (e.code == 'wrong-password') {
        showDialog(
          context: _context,
          builder: (_) => AssetGiffDialog(
            //? try again button
            buttonOkColor: Get.theme.primaryColor,
            buttonOkText: Text(
              'Try Again',
              style: TextStyle(
                color: Get.isDarkMode
                    ? kTextButtonColorDarkTheme
                    : kTextButtonColorLightTheme,
              ),
            ),
            //? reset button
            buttonCancelColor:
                Get.isDarkMode ? kButtonColorDarkTheme : kButtonColorLightTheme,
            buttonCancelText: Text(
              'Reset',
              style: TextStyle(
                color: Get.theme.primaryColor,
              ),
            ),
            onCancelButtonPressed: () {
              Get.back();
              Get.to(() => const ForgotPassword());
            },
            image: Image.asset(
              'assets/gifs/user_not_found.gif',
              fit: BoxFit.cover,
            ),
            entryAnimation: EntryAnimation.bottom,
            title: const Text(
              'Incorrect Password 🤔',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            ),
            description: const Text(
              'Please make sure your password is correct ✔ \nIf you forgot your password you can reset it now by clicking the reset button 😉',
              textAlign: TextAlign.center,
            ),
            onOkButtonPressed: () {
              Get.back();
            },
          ),
        );
      }
    } catch (e) {
      somethingWentWrongDialog(_context);
    }
  }

  //sign up new student account
  Future<void> createStudentAccount(
    String _accessCode,
    String _fullName,
    String _college,
    int _studentNumber,
    String _emailAddress,
    String _password,
    _context,
  ) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: _emailAddress, password: _password)
          .then((value) => {
                firestore
                    .collection('student')
                    .doc(_auth.currentUser!.uid)
                    .set({
                  'regs-access-code': _accessCode,
                  'student-name': _fullName,
                  'college': _college,
                  'student-number': _studentNumber,
                  'profile-image-url': kDefaultProfile,
                  'student-email': _emailAddress,
                  'channels': [],
                }).whenComplete(() {
                  firestore
                      .collection('professor-access-code')
                      .doc(_accessCode)
                      .delete();
                  Get.off(() => const MainFeed());
                })
              });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // _customDialog.dialog(
        //   'WEAK PASSWORD',
        //   'The password provided is too weak',
        // );
      } else if (e.code == 'email-already-in-use') {
        emailAlreadyInUse(_context); // student
      }
    } catch (e) {
      somethingWentWrongDialog(_context);
    }
  }

  //sign up new professor account
  Future<void> createProfessorAccount(
    String _accessCode,
    String _fullName,
    int _contactNumber,
    int _employeeNumber,
    String _emailAddress,
    String _password,
    _context,
  ) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: _emailAddress, password: _password)
          .then((value) => {
                firestore
                    .collection('professor')
                    .doc(_auth.currentUser!.uid)
                    .set({
                  'regs-access-code': _accessCode,
                  'profile-image-url': kDefaultProfile,
                  'professor-name': _fullName,
                  'contact-number': _contactNumber,
                  'employee-number': _employeeNumber,
                  'professor-email': _emailAddress,
                }).whenComplete(() {
                  firestore
                      .collection('professor-access-code')
                      .doc(_accessCode)
                      .delete();
                  Get.off(() => const MainFeed());
                })
              });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // _customDialog.dialog(
        //   'WEAK PASSWORD',
        //   'The password provided is too weak',
        // );
      } else if (e.code == 'email-already-in-use') {
        emailAlreadyInUse(_context);
      }
    } catch (e) {
      somethingWentWrongDialog(_context);
    }
  }

  // reset password
  Future<void> resetPassword(String _email, _context) async {
    try {
      await _auth.sendPasswordResetEmail(email: _email).whenComplete(
            () => showDialog(
              context: _context,
              builder: (_) => AssetGiffDialog(
                onlyOkButton: true,
                buttonOkColor: Get.theme.primaryColor,
                image: Image.asset(
                  'assets/gifs/email_sent.gif',
                  fit: BoxFit.cover,
                ),
                entryAnimation: EntryAnimation.bottom,
                title: const Text(
                  'Mail Sent 💌',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
                ),
                description: const Text(
                  'We have e-mailed your password reset link! 🤗',
                  textAlign: TextAlign.center,
                ),
                onOkButtonPressed: () {
                  Get.back();
                },
              ),
            ),
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {}
    } catch (e) {
      somethingWentWrongDialog(_context);
    }
  }

  //something went wrong dialog
  Future<dynamic> somethingWentWrongDialog(_context) {
    return showDialog(
      context: _context,
      builder: (_) => AssetGiffDialog(
        onlyOkButton: true,
        buttonOkColor: Get.theme.primaryColor,
        image: Image.asset(
          'assets/gifs/something_went_wrong.gif',
          fit: BoxFit.cover,
        ),
        entryAnimation: EntryAnimation.bottom,
        title: const Text(
          'Someting Went Wrong 😕',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
        ),
        description: const Text(
          'Please restart the app or contact tech support 👨🏻‍💻',
          textAlign: TextAlign.center,
        ),
        onOkButtonPressed: () {
          Get.back();
        },
      ),
    );
  }

  //email already in use dialog
  Future<dynamic> emailAlreadyInUse(_context) {
    return showDialog(
      context: _context,
      builder: (_) => AssetGiffDialog(
        //? try again button
        buttonOkColor: Get.theme.primaryColor,

        //? reset button
        buttonCancelColor:
            Get.isDarkMode ? kButtonColorDarkTheme : kButtonColorLightTheme,
        buttonCancelText: Text(
          'Reset',
          style: TextStyle(
            color: Get.theme.primaryColor,
          ),
        ),
        onCancelButtonPressed: () {
          Get.back();
          Get.to(() => const ForgotPassword());
        },
        image: Image.asset(
          'assets/gifs/exsisting_account_found.gif',
          fit: BoxFit.cover,
        ),
        entryAnimation: EntryAnimation.bottom,
        title: const Text(
          'Email Already In Use 🤨',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
        ),
        description: const Text(
          'Your email is already in use 🤔 \nIf you forgot your password you can change it now by clicking the reset button 😉',
          textAlign: TextAlign.center,
        ),
        onOkButtonPressed: () {
          Get.back();
        },
      ),
    );
  }

  //signedout
  Future<void> signOut() async {
    _auth.signOut();
    //shared preferences initialization
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('signInToken');
    Get.off(() => kIsWeb ? const WebView() : const PhoneView());
  }
}
