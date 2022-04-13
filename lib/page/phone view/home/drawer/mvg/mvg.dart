import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';

import '../../../../../widgets/appbar/build_appbar.dart';

class MVC extends StatelessWidget {
  const MVC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(
          context: context,
          title: 'MVC',
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTitle(
                  context: context,
                  title: 'Mission',
                ),
                const Divider(),
                _buildAnimatedText(
                    context: context,
                    content: mission,
                    duration: const Duration(milliseconds: 20)),
                SizedBox(
                  height: 5.h,
                ),
                _buildTitle(
                  context: context,
                  title: 'Vision',
                ),
                const Divider(),
                _buildAnimatedText(
                  context: context,
                  content: vision,
                  duration: const Duration(milliseconds: 40),
                ),
                SizedBox(
                  height: 5.h,
                ),
                _buildTitle(
                  context: context,
                  title: 'Core Values',
                ),
                const Divider(),
                _buildAnimatedText(
                  context: context,
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
  required BuildContext context,
}) {
  return DefaultTextStyle(
    style: TextStyle(
      color: Theme.of(context).primaryColor,
      fontSize: 25.sp,
    ),
    child: AnimatedTextKit(
      isRepeatingAnimation: false,
      animatedTexts: [
        TyperAnimatedText(
          title,
          textAlign: TextAlign.center,
          speed: const Duration(
            milliseconds: 150,
          ),
        ),
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
  required BuildContext context,
}) {
  return DefaultTextStyle(
    style: TextStyle(
      color: Theme.of(context).textTheme.labelMedium!.color,
    ),
    child: AnimatedTextKit(
      isRepeatingAnimation: false,
      animatedTexts: [
        TypewriterAnimatedText(
          content,
          textAlign: TextAlign.center,
          speed: duration,
        ),
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
