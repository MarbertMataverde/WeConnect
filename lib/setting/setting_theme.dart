import 'package:flutter/material.dart';

final lightThemeData = ThemeData(
  visualDensity: VisualDensity.comfortable,
  primaryColor: const Color(0xff05AAFA),
  scaffoldBackgroundColor: const Color(0xffffffff),
  iconTheme: const IconThemeData(color: Color(0xff003366)),
  cardTheme: const CardTheme(
    elevation: 2,
    color: Color(0xffffffff),
    shadowColor: Color.fromARGB(70, 0, 0, 0),
  ),
  disabledColor: const Color.fromARGB(255, 160, 160, 160),
  textTheme: const TextTheme(
    labelMedium: TextStyle(color: Color.fromARGB(200, 11, 24, 47)),
    bodySmall: TextStyle(color: Color(0xff003366)),
    bodyMedium: TextStyle(color: Color(0xff003366)),
    bodyLarge: TextStyle(color: Color(0xff003366)),
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
  scaffoldBackgroundColor: const Color(0xff003366),
  iconTheme: const IconThemeData(color: Colors.white),
  cardColor: const Color(0xff003366),
  cardTheme: const CardTheme(
    elevation: 1,
    color: Color(0xff003366),
    shadowColor: Color.fromARGB(70, 255, 255, 255),
  ),
  disabledColor: const Color.fromARGB(255, 95, 95, 95),
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
