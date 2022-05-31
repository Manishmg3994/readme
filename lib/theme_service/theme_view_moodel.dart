import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeViewModel with ChangeNotifier {
  final _box = GetStorage();
  final _key = 'isDarkMode';
  ThemeMode get theme => _darkMode ? ThemeMode.dark : ThemeMode.light;
  //ThemeMode.system

  bool get darkMode => _darkMode;
  set darkMode(bool value) {
    if (_darkMode == value) {
      return;
    }

    _darkMode = value;
    Get.changeThemeMode(theme);
    notifyListeners();
  }

  bool _darkMode = GetStorage().read('isDarkMode') ?? false;

  void saveTheme(bool isDarkMode) => _box.write(_key, isDarkMode);
}
