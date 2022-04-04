import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Widget namedDivider({required BuildContext context, String? dividerName}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //account
      Padding(
        padding: EdgeInsets.only(left: 5.w),
        child: dividerName != null
            ? Text(
                dividerName,
                textScaleFactor: 1.1,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
      ),
      //divider
      Divider(
          indent: 5.w,
          endIndent: 20.w,
          thickness: 0.5,
          color: Theme.of(context).primaryColor.withAlpha(150)),
    ],
  );
}
