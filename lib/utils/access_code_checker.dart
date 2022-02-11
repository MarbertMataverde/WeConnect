import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:weconnect/views/phone%20view/sign%20up/student%20sign%20up/student_signup_page.dart';

import '../views/phone view/sign up/professor sign up/professor_signup_page.dart';

final firestore = FirebaseFirestore.instance;

class AccessCodeChecker extends GetxController {
  Future professorAccessCodeChecker(
    String _accessCode,
  ) async {
    await firestore
        .collection('professor-access-code')
        .doc(_accessCode)
        .get()
        .then(
          (professorDocSnapshot) => {
            professorDocSnapshot.exists
                ? Get.to(() => const ProfessorSignUpPage(),
                    arguments: _accessCode)
                : debugPrint(
                    'No Access Code Like That In Professor Access Code Database')
          },
        );
  }

  Future studentAccessCodeChecker(
    String _accessCode,
  ) async {
    await firestore
        .collection('student-access-code')
        .doc(_accessCode)
        .get()
        .then(
          (studentDocSnapshot) => {
            studentDocSnapshot.exists
                ? Get.to(() => const StudentSignUpPage(),
                    arguments: _accessCode)
                : debugPrint(
                    'No Access Code Like That In Student Access Code Database')
          },
        );
  }
}
