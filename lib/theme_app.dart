import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkTheme = false;

  Color get getBgColor {
    return isDarkTheme ? Color.fromARGB(255, 184, 221, 251) : Color.fromARGB(255, 63, 85, 122);
  }
  Color get getAbColor {
    return isDarkTheme ?Color.fromARGB(255, 184, 221, 251) : Color.fromARGB(255, 63, 85, 122);
  }
  Color get getTextColor {
    return isDarkTheme ?Color.fromARGB(255, 13, 13, 13) : Color.fromARGB(255, 254, 254, 255);
  }
  Icon get getAbIcon {
    return isDarkTheme ?Icon(Icons.sunny):Icon(Icons.brightness_2_sharp);
  }
  void changeTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }
}
