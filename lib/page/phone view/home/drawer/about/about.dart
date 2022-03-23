import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/widgets/appbar/appbar_back.dart';
import 'package:weconnect/widgets/appbar/appbar_title.dart';

import '../../../../../constant/constant_colors.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: buildAppbarBackButton(),
          title: const AppBarTitle(title: 'About'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _aboutHeadingTitle(),
              const Divider(),
              _aboutContent(),
            ],
          ),
        ));
  }
}

Widget _aboutHeadingTitle() {
  return RichText(
    text: TextSpan(
      text: 'Brief History of\n',
      style: TextStyle(
          color: Get.isDarkMode ? kTextColorDarkTheme : kTextColorLightTheme,
          fontSize: 18.sp),
      children: <TextSpan>[
        TextSpan(
          text: 'URS Binangonan',
          style: TextStyle(
            color: Get.isDarkMode ? kTextColorDarkTheme : kTextColorLightTheme,
            fontSize: 22.sp,
          ),
        ),
      ],
    ),
  );
}

Widget _aboutContent() {
  return Flexible(
    child: Text(
      '''URS Binangonan campus started out as an extension campus of Rizal State College (RSC). The building where it is now situated was initially constructed to house the Vicente Madrigal National High School and was inaugurated on August 26, 1998. But through the efforts of Dr. Heracleo Lagrada, president of RSC, and with the aid of Dr. Edith Doblada, DECS Superintendent, RSC requested the Hon. Cong. Gilberto M. Duavit and Hon. Gov. Casimiro Ynares Jr. to allow RSC to occupy the newly constructed building. The first floor of the building was then occupied by the Rizal Science High School while the second and third floor housed the RSC Binangonan Campus. Under the supervision of the College Director, Dr Reenecilla Paz De leon, and Deputy Director Mr. Norven Doblada, RSC Binangonan Campus maintained three institutes: The Institute of Cooperative, Economics, and Management (ICEM), Institute of Fisheries and Sciences (IFAS) and the Graduate School. The campus initially catered to 1,116 students and 38 faculty members and started the operation on June 04, 1998.
  ''',
      style: TextStyle(
        color: Get.isDarkMode ? kTextColorDarkTheme : kTextColorLightTheme,
      ),
    ),
  );
}
