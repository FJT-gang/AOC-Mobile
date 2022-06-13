import 'package:flutter/material.dart';

// Globals
import 'package:aoc/general/globals.dart';

class ThemeProv extends ChangeNotifier {
  Color bgColor = Globals.bgLightBlue;
  Color grStart = Globals.grBlueStart;
  Color grEnd = Globals.grBlueEnd;
  Color homecard = Globals.bgDarkBlue;
  String color = 'blue';

  void changeTheme(colorr) {
    color = colorr;
    if (colorr == 'blue') {
      bgColor = Globals.bgLightBlue;
      grStart = Globals.grBlueStart;
      grEnd = Globals.grBlueEnd;
      homecard = Globals.bgDarkBlue;
    } else if (colorr == 'orange') {
      bgColor = Globals.bgOrange;
      grStart = Globals.grOrangeStart;
      grEnd = Globals.grOrangeEnd;
      homecard = Color.fromARGB(255, 255, 136, 0);
    }

    notifyListeners();
  }
}
