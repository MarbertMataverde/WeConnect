import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../views/web view/home/home_student_axcode.dart';

//initializing firebase auth as _auth
final FirebaseAuth _auth = FirebaseAuth.instance;

class Authentication extends GetxController {
  //sign in
  Future<void> signIn(
    String _email,
    String _password,
  ) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      //*GETTING THE ROLE OF THE USER WHO JUST LOGGED IN
      // _roleRouteLogic.getUserRoleAndScreenRoutingLogic(_auth.currentUser!.uid);
      debugPrint('Sign In Success');
      Get.to(() => StudentAxCodeGenerator());
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
}
