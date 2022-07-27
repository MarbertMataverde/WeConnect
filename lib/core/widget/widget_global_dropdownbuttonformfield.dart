import 'package:flutter/material.dart';

Widget globalDropdownButtonFormField({
  required BuildContext context,
  String hintText = '',
  required List<DropdownMenuItem<String>>? items,
  required Function(String?)? onChange,
  required String? value,
}) {
  return DropdownButtonFormField<String>(
    dropdownColor: const Color(0xff323645),
    isExpanded: true,
    style: TextStyle(
      color: Theme.of(context).textTheme.bodyMedium!.color,
    ),
    decoration: InputDecoration(
      hintStyle: TextStyle(
          color: Theme.of(context).textTheme.bodyMedium!.color?.withAlpha(150)),
      filled: true,
      fillColor: const Color(0xff323645),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(2),
        borderSide: BorderSide.none,
      ),
    ),
    hint: hintText != ''
        ? Text(
            hintText,
            style: TextStyle(
              color:
                  Theme.of(context).textTheme.bodyMedium!.color?.withAlpha(150),
            ),
          )
        : null,
    value: value,
    items: items,
    onChanged: onChange,
  );
}
