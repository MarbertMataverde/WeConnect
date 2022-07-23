import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:giff_dialog/giff_dialog.dart';

import '../page/phone view/sign up/professor sign up/professor_signup_page.dart';
import '../page/phone view/sign up/student sign up/student_signup_page.dart';

final firestore = FirebaseFirestore.instance;

class AccessCodeChecker extends GetxController {
  //professor access code checker
  Future professorAccessCodeChecker(
    String accessCode,
    context,
  ) async {
    await firestore
        .collection('professor-access-code')
        .doc(accessCode)
        .get()
        .then(
          (professorDocSnapshot) => {
            professorDocSnapshot.exists
                ? Get.to(() => const ProfessorSignUpPage(),
                    arguments: accessCode)
                : wrongAccessCodeDialog(context),
          },
        );
  }

  //student access code checher
  Future studentAccessCodeChecker(
    String accessCode,
    context,
  ) async {
    await firestore
        .collection('student-access-code')
        .doc(accessCode)
        .get()
        .then(
          (studentDocSnapshot) => {
            studentDocSnapshot.exists
                ? Get.to(() => const StudentSignUpPage(), arguments: accessCode)
                : wrongAccessCodeDialog(context)
          },
        );
  }

  Future<dynamic> wrongAccessCodeDialog(context) {
    return showDialog(
      context: context,
      builder: (_) => AssetGiffDialog(
        onlyOkButton: true,
        buttonOkColor: Theme.of(context).primaryColor,
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
