import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'setting/them_config.dart';

import 'firebase_options.dart';
import 'page/phone view/sign in/phone_view.dart';
import 'page/phone%20view/home/home_phone_wrapper.dart';
import 'page/web view/sign in/web_view.dart';
import 'setting/setting_theme.dart';

//TODO Rebuild the entire app for web and make it responsive!

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  getAccountInformation();
  // whenever your initialization is completed, remove the splash screen:
  FlutterNativeSplash.remove();

  runApp(const InitialPage());
}

Future getAccountInformation() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  accountInformation.getter(sharedPreferences.get('currentUid').toString());
}

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    currentTheme.addListener(() {
      setState(() {});
    });
    super.initState();
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
          themeMode: currentTheme.currentTheme(),
          defaultTransition: Transition.fadeIn,
          home: LayoutBuilder(
            builder: (context, constraints) {
              //?phone view
              if (constraints.maxWidth < 768) {
                return const PhoneViewSignIn();
              } else {
                return const WebView();
              }
            },
          ),
        );
      },
    );
  }
}
