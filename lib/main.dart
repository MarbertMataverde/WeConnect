import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'firebase_options.dart';
import 'themes/themes.dart';
import 'views/phone view/home/main feed/main_feed.dart';
import 'views/phone view/sign in/phone_view.dart';
import 'views/web view/home/home_student_axcode.dart';
import 'views/web view/sign in/web_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const InitialPage());
}

//valitaion varialble
bool _isSignedIn = false;

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    isSignedIn();
    super.initState();
  }

  Future isSignedIn() async {
    //shared preferences initialization
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final _uid = sharedPreferences.get('signInToken');
    setState(() {
      _isSignedIn = _uid != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: 'Material App',
          debugShowCheckedModeBanner: false,
          theme: lightThemeData,
          darkTheme: darkThemeData,
          themeMode: ThemeMode.dark,
          home: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                //phone view
                if (constraints.maxWidth < 768) {
                  return _isSignedIn ? const MainFeed() : const PhoneView();
                } else {
                  //web view
                  return _isSignedIn
                      ? const StudentAxCodeGenerator()
                      : const WebView();
                }
              },
            ),
          ),
        );
      },
    );
  }
}
