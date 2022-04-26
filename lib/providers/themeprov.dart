import 'package:flutter/material.dart';

// Globals
import 'package:aoc/general/globals.dart';

class ThemeProv extends ChangeNotifier {
  Color bgColor = Globals.bgLightBlue;

  void changeTheme(color) {
    if (color == 'blue') {
      bgColor = Globals.bgLightBlue;
    } else if (color == 'orange') {
      bgColor = Globals.bgOrange;
    }

    notifyListeners();
  }
}
