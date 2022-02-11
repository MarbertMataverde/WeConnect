import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:weconnect/views/phone%20view/sign%20in/phone_view.dart';

import '../constant/constant.dart';
import '../views/phone view/home/main feed/main_feed.dart';

//*INITIALIZING FIRESTORE as firestore
final firestore = FirebaseFirestore.instance;

//initializing firebase auth as _auth
final FirebaseAuth _auth = FirebaseAuth.instance;

class Authentication extends GetxController {
  //sign in
  Future<void> signIn(
    String _emailAddress,
    String _password,
  ) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _emailAddress, password: _password);
      //*GETTING THE ROLE OF THE USER WHO JUST LOGGED IN
      // _roleRouteLogic.getUserRoleAndScreenRoutingLogic(_auth.currentUser!.uid);
      debugPrint('Sign In Success');
      // Get.off(() => const MainFeed());
      // Get.to(() => const StudentAxCodeGenerator());
      //*WE CAN USE THIS FOR THE WHOLE APP FUNCTIONALITY LIKE UPLOAD/COMMENT AND MORE
      // box.write('uid', _auth.currentUser!.uid); //*THIS IS OUR USER IDENTIFIER
      update();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
      } else if (e.code == 'wrong-password') {}
    } catch (e) {
      debugPrint(e.toString());
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
                  // _customDialog.dialog(
                  //   'REGISTRATION COMPLETE',
                  //   'You can now log in with your accout',
                  // );
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
        // _customDialog.dialog(
        //   'EXISTING EMAIL',
        //   'The account already exists for that email',
        // );
      }
    } catch (e) {
      // _customDialog.dialog(
      //   'SOMETHING WENT WRONG',
      //   e.toString(),
      // );
    }
  }

  //sign up new student account
  Future<void> createProfessorAccount(
    String _accessCode,
    String _fullName,
    int _contactNumber,
    int _employeeNumber,
    String _emailAddress,
    String _password,
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
                  'student-name': _fullName,
                  'contact-number': _contactNumber,
                  'employee-number': _employeeNumber,
                  'student-email': _emailAddress,
                }).whenComplete(() {
                  // _customDialog.dialog(
                  //   'REGISTRATION COMPLETE',
                  //   'You can now log in with your accout',
                  // );
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
        // _customDialog.dialog(
        //   'EXISTING EMAIL',
        //   'The account already exists for that email',
        // );
      }
    } catch (e) {
      // _customDialog.dialog(
      //   'SOMETHING WENT WRONG',
      //   e.toString(),
      // );
    }
  }

  // reset password
  Future<void> resetPassword(String _email) async {
    try {
      await _auth.sendPasswordResetEmail(email: _email).then((value) => {
            // _customDialog.dialog(
            //   'EMAIL SENT',
            //   'Please check your email and click\nthe link to reset your password',
            // )
          });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // _customDialog.dialog(
        //   'USER NOT FOUND',
        //   'Make sure your email is correct',
        // );
      }
    } catch (e) {
      // _customDialog.dialog(
      //   'SOMETHING WENT WRONG',
      //   e.toString(),
      // );
    }
  }
}
