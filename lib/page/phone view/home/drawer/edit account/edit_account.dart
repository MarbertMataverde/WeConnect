import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/widgets/appbar/build_appbar.dart';
import 'package:weconnect/widgets/text%20form%20field/custom_textformfield.dart';
import '../../../../../controller/controller_account_information.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({Key? key}) : super(key: key);

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  File? selectedImage;

  Future pickImage() async {
    try {
      final selectedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (selectedImage == null) {
        return;
      }
      final selectedTempImage = File(selectedImage.path);
      setState(() {
        this.selectedImage = selectedTempImage;
      });
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
    }
  }

  //account type
  final String docAccountType = currentAccountType == 'accountTypeCampusAdmin'
      ? 'campus-admin'
      : currentAccountType == 'accountTypeRegistrarAdmin'
          ? 'registrar-admin'
          : currentAccountType == 'accountTypeCoaAdmin'
              ? 'coa-admin'
              : currentAccountType == 'accountTypeCobAdmin'
                  ? 'cob-admin'
                  : currentAccountType == 'accountTypeCcsAdmin'
                      ? 'ccs-admin'
                      : currentAccountType == 'accountTypeMasteralAdmin'
                          ? 'masteral-admin'
                          : currentAccountType == 'accountTypeProfessor'
                              ? 'professors'
                              : 'students'; //if studnet

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance
        .collection('accounts')
        .doc(docAccountType)
        .collection('account');
    return Scaffold(
      appBar: buildAppBar(
        context: context,
        title: 'Edit Account',
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Iconsax.arrow_square_left,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc(currentUserId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Padding(
              padding: EdgeInsets.only(top: 2.h),
              child: Column(
                children: [
                  selectedImage != null
                      ? buildNewProfileImage(
                          context: context,
                          onCliked: () => pickImage(),
                          newProfileImage: selectedImage,
                        )
                      : buildPreviousProfileImage(
                          context: context,
                          onCliked: () => pickImage(),
                        ),
                  SizedBox(
                    height: 1.h,
                  ),
                  //name
                  Text(
                    data['profile-name'],
                    textScaleFactor: 1.2,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // email
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(
                              ClipboardData(text: data['profile-email']))
                          .then(
                        (value) => Get.showSnackbar(
                          GetSnackBar(
                            icon: Icon(
                              MdiIcons.checkBold,
                              color: Theme.of(context).primaryColor,
                            ),
                            margin: EdgeInsets.all(2.w),
                            borderRadius: 1.w,
                            backgroundColor:
                                Theme.of(context).primaryColor.withAlpha(100),
                            message: 'Email copied to clipboard',
                            duration: const Duration(seconds: 1),
                            forwardAnimationCurve:
                                Curves.fastLinearToSlowEaseIn,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      data['profile-email'],
                      textScaleFactor: 0.9,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  //account type
                  currentAccountType == 'accountTypeCampusAdmin' ||
                          currentAccountType == 'accountTypeRegistrarAdmin'
                      ? Text(
                          accountType,
                          textScaleFactor: 0.9,
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.labelMedium!.color,
                          ),
                        )
                      : Text(
                          data['college'],
                          textScaleFactor: 0.9,
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.labelMedium!.color,
                          ),
                        ),

                  Divider(
                    height: 5.h,
                  ),
                  currentAccountType == 'accountTypeCampusAdmin' ||
                          currentAccountType == 'accountTypeRegistrarAdmin'
                      ? buildEditableTextField(
                          isEnable: false,
                          context: context,
                          label: 'Full Name',
                          initialValue: data['profile-name'],
                        )
                      : Column(
                          children: [
                            buildEditableTextField(
                              context: context,
                              label: 'Full Name  (LN, FN MI)',
                              initialValue: data['profile-name'],
                            ),
                            buildEditableTextField(
                              isEnable: false,
                              context: context,
                              label: 'Student Number',
                              initialValue: data['student-number'].toString(),
                            ),
                          ],
                        ),
                ],
              ),
            );
          }

          return const Text("loading");
        },
      ),
    );
  }
}

Widget buildPreviousProfileImage({
  VoidCallback? onCliked,
  required BuildContext context,
}) {
  return Center(
    child: Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: onCliked,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.w),
            child: Image.network(
              currentProfileImageUrl!,
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.width * 0.25,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildNewProfileImage({
  required BuildContext context,
  VoidCallback? onCliked,
  File? newProfileImage,
}) {
  return Center(
    child: Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: onCliked,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.w),
            child: Image.file(
              newProfileImage!,
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.width * 0.25,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    ),
  );
}

//build editable textfield
Widget buildEditableTextField({
  required BuildContext context,
  required String label,
  required String initialValue,
  bool? isEnable,
  Color? disableColor,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 1.w),
          child: Text(
            label,
            textScaleFactor: 1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.labelMedium!.color,
            ),
          ),
        ),
        CustomTextFormField(
          disableColor: disableColor,
          isEnable: isEnable,
          initialValue: initialValue,
          minimumLine: 1,
          maxLine: 1,
          isPassword: false,
          validator: (_) {},
        ),
      ],
    ),
  );
}

final String accountType = currentAccountType == 'accountTypeCampusAdmin'
    ? 'Campus Admin'
    : currentAccountType == 'accountTypeRegistrarAdmin'
        ? 'Registrar Admin'
        : currentAccountType == 'accountTypeCoaAdmin'
            ? 'College of Accountancy Admin'
            : currentAccountType == 'accountTypeCobAdmin'
                ? 'College of Business Admin'
                : currentAccountType == 'accountTypeCcsAdmin'
                    ? 'College of Computer Studies Admin'
                    : currentAccountType == 'accountTypeMasteralAdmin'
                        ? 'Masteral Admin'
                        : currentAccountType == 'accountTypeProfessor'
                            ? 'Professor'
                            : currentStudentCollege.toString();
