import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giff_dialog/giff_dialog.dart';
import 'package:weconnect/views/phone%20view/sign%20up/student%20sign%20up/student_signup_page.dart';

import '../views/phone view/sign up/professor sign up/professor_signup_page.dart';

final firestore = FirebaseFirestore.instance;

class AccessCodeChecker extends GetxController {
  //professor access code checker
  Future professorAccessCodeChecker(
    String _accessCode,
    _context,
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
                : wrongAccessCodeDialog(_context),
          },
        );
  }

  //student access code checher
  Future studentAccessCodeChecker(
    String _accessCode,
    _context,
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
                : wrongAccessCodeDialog(_context)
          },
        );
  }

  Future<dynamic> wrongAccessCodeDialog(_context) {
    return showDialog(
      context: _context,
      builder: (_) => AssetGiffDialog(
        onlyOkButton: true,
        buttonOkColor: Get.theme.primaryColor,
        image: Image.asset(
          'assets/gifs/empty_data.gif',
          fit: BoxFit.cover,
        ),
        entryAnimation: EntryAnimation.bottom,
        title: const Text(
          'Access Code Not Found 😶',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
        ),
        description: const Text(
          'Looks Like your access code is not correct 🤔',
          textAlign: TextAlign.center,
        ),
        onOkButtonPressed: () {
          Get.back();
        },
      ),
    );
  }
}
