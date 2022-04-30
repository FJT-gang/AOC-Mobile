import 'package:flutter/material.dart';

// Globals
import 'package:aoc/general/globals.dart';

class ThemeProv extends ChangeNotifier {
  Color bgColor = Globals.bgLightBlue;
  Color grStart = Globals.grBlueStart;
  Color grEnd = Globals.grBlueEnd;

  void changeTheme(color) {
    if (color == 'blue') {
      bgColor = Globals.bgLightBlue;
      grStart = Globals.grBlueStart;
      grEnd = Globals.grBlueEnd;
    } else if (color == 'orange') {
      bgColor = Globals.bgOrange;
      grStart = Globals.grOrangeStart;
      grEnd = Globals.grOrangeEnd;
    }

    notifyListeners();
  }
}
