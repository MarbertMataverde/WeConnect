import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'firebase_options.dart';
import 'page/phone view/sign in/phone_view.dart';
import 'page/phone%20view/home/home_phone_wrapper.dart';
import 'page/web view/home/home_web_wrapper.dart';
import 'page/web view/sign in/web_view.dart';
import 'setting/setting_theme.dart';

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
          title: 'WeConnect URS Poral 🔥',
          debugShowCheckedModeBanner: false,
          theme: lightThemeData,
          darkTheme: darkThemeData,
          themeMode: ThemeMode.system,
          home: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                //?phone view
                if (constraints.maxWidth < 768) {
                  return _isSignedIn
                      ? const HomePhoneWrapper()
                      : const PhoneViewSignIn();
                }
                //you can add layout for tablet too
                //theirs one more sing in bug for web
                // !!!!!!!!!!!!!BUUUUUUUUUUUUUGGGGGGGGGGGGGGG!!!!!!!!!!!!!!!!
                // ! if the other account type try to signed-in in web base
                // ! the _isSignedIn will be set to false even if will not navigated
                // ! to HomeWebWrapper. If the user reload the page the sharedPrps
                // ! will be excuted and the stored data will be get and automaticaly
                // ! navigate to HomeWebWrapper even if the account type is not
                // ! campus admin.
                // !web view
                else {
                  return _isSignedIn ? const HomeWebWrapper() : const WebView();
                }
              },
            ),
          ),
        );
      },
    );
  }
}
