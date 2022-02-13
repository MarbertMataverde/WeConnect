import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sizer/sizer.dart';
import 'firebase_options.dart';
import 'themes/themes.dart';
import 'views/signin body/signin_body.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const InitialPage());
}

class InitialPage extends StatelessWidget {
  const InitialPage({Key? key}) : super(key: key);

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
          home: const SignInBody(),
        );
      },
    );
  }
}
