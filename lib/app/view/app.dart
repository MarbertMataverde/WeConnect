import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weconnect/features/login/view/view_login.dart';
import 'package:weconnect/setting/setting_theme.dart';

import '../../firebase_options.dart';
import '../../page/phone%20view/home/home_phone_wrapper.dart';

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
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightThemeData,
        themeMode: ThemeMode.dark,
        darkTheme: darkThemeData,
        home: const Login());
  }
}
