import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControllerChangeTheme extends GetxController {
  void toggleChangeTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (Get.isDarkMode) {
      sharedPreferences.setString('theme', 'light');
    } else {
      sharedPreferences.setString('theme', 'dark');
    }
    update();
  }
}
