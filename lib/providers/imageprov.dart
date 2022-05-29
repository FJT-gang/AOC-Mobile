import 'package:flutter/material.dart';

class ImageProv extends ChangeNotifier {
  List<Widget> images = [];

  void sImages(img) {
    images.add(img);
    notifyListeners();
  }

  void reset() {
    images = [];
  }
}
