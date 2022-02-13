import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:weconnect/views/signin%20body/signin_body.dart';
import 'firebase_options.dart';
import 'themes/themes.dart';

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
          themeMode: ThemeMode.dark,
          home: SignInBody(
            isSignedIn: _isSignedIn,
          ),
        );
      },
    );
  }
}
