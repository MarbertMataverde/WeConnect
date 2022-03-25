import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'firebase_options.dart';
import 'page/phone view/sign in/phone_view.dart';
import 'page/phone%20view/home/home_phone_wrapper.dart';
import 'page/web view/sign in/web_view.dart';
import 'setting/setting_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const InitialPage());
}

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    getAccountInformation();
    super.initState();
  }

  Future getAccountInformation() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    accountInformation.getter(sharedPreferences.get('currentUid').toString());
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: 'WeConnect URS Poral 🔥',
          debugShowCheckedModeBanner: false,
          theme: lightThemeData,
          darkTheme: darkThemeData,
          themeMode: ThemeMode.light,
          home: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                //?phone view
                if (constraints.maxWidth < 768) {
                  return const PhoneViewSignIn();
                } else {
                  return const WebView();
                }
                //testing branches
              },
            ),
          ),
        );
      },
    );
  }
}
