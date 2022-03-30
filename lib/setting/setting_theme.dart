import 'package:flutter/material.dart';

final lightThemeData = ThemeData(
  visualDensity: VisualDensity.comfortable,
  primaryColor: const Color(0xff05AAFA),
  scaffoldBackgroundColor: const Color(0xffffffff),
  iconTheme: const IconThemeData(color: Color(0xff0B182F)),
  cardTheme: const CardTheme(
    elevation: 2,
    color: Color(0xffffffff),
    shadowColor: Color.fromARGB(70, 0, 0, 0),
  ),
  disabledColor: const Color(0xff172A46),
  textTheme: const TextTheme(
    labelMedium: TextStyle(color: Color.fromARGB(200, 11, 24, 47)),
    bodySmall: TextStyle(color: Color(0xff0B182F)),
    bodyMedium: TextStyle(color: Color(0xff0B182F)),
    bodyLarge: TextStyle(color: Color(0xff0B182F)),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          const Color(0xffcacaca);
        }
        return Colors.transparent;
      }),
      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        return const Color(0xff05AAFA);
      }),
    ),
  ),
  fontFamily: 'Inter',
);

final darkThemeData = ThemeData(
  visualDensity: VisualDensity.comfortable,
  primaryColor: const Color(0xff03E0CF),
  scaffoldBackgroundColor: const Color(0xff0B182F),
  iconTheme: const IconThemeData(color: Colors.white),
  cardColor: const Color(0xff0B182F),
  cardTheme: const CardTheme(
    elevation: 1,
    color: Color(0xff0B182F),
    shadowColor: Color.fromARGB(70, 255, 255, 255),
  ),
  disabledColor: const Color.fromARGB(169, 251, 251, 251),
  textTheme: const TextTheme(
      labelMedium: TextStyle(color: Color.fromARGB(200, 255, 255, 255)),
      bodySmall: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      bodyLarge: TextStyle(color: Colors.white)),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          const Color(0xffcacaca);
        }
        return Colors.transparent;
      }),
      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        return const Color(0xff03E0CF);
      }),
    ),
  ),
  fontFamily: 'Inter',
);
