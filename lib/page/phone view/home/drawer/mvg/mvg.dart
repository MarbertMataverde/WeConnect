import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/constant/constant_colors.dart';

import '../../../../../widgets/appbar/appbar_title.dart';

class MVG extends StatelessWidget {
  const MVG({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const AppBarTitle(title: 'URS M-V-G'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(title: '🎯 Mission'),
                const Divider(),
                _buildAnimatedText(
                    content: mission,
                    duration: const Duration(milliseconds: 20)),
                SizedBox(
                  height: 5.h,
                ),
                _buildTitle(title: '👁️ Vision'),
                const Divider(),
                _buildAnimatedText(
                  content: vision,
                  duration: const Duration(milliseconds: 40),
                ),
                SizedBox(
                  height: 5.h,
                ),
                _buildTitle(title: '☺ Core Values'),
                const Divider(),
                _buildAnimatedText(
                  content: coreValues,
                  duration: const Duration(milliseconds: 70),
                ),
              ],
            ),
          ),
        ));
  }
}

Widget _buildTitle({
  required String title,
}) {
  return DefaultTextStyle(
    style: TextStyle(
      color: Get.isDarkMode ? kTextColorDarkTheme : kTextColorLightTheme,
      fontSize: 20.sp,
    ),
    child: AnimatedTextKit(
      isRepeatingAnimation: false,
      animatedTexts: [
        TyperAnimatedText(title, speed: const Duration(milliseconds: 150)),
      ],
      onTap: () {
        debugPrint("Tap Event");
      },
    ),
  );
}

Widget _buildAnimatedText({
  required String content,
  required Duration duration,
}) {
  return DefaultTextStyle(
    style: TextStyle(
      color: Get.isDarkMode ? kTextColorDarkTheme : kTextColorLightTheme,
    ),
    child: AnimatedTextKit(
      isRepeatingAnimation: false,
      animatedTexts: [
        TypewriterAnimatedText(content, speed: duration),
      ],
      onTap: () {
        debugPrint("Tap Event");
      },
    ),
  );
}

const String mission =
    'The University of Rizal System is committed to nurture and produce upright and competent graduates and empowered community through relevant and sustainable higher professional and technical instruction, research, extension and production services.';

const String vision =
    'The leading University in human resource development, knowledge and technology generation and environmental stewardship.';

const String coreValues =
    'Responsiveness\nIntegrity\nService\nExcellence\nSocial Responsibility';
