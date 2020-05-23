import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class Conductor extends ChangeNotifier {
  Conductor() {
    initOffset();
  }

  int _index = 0;

  int get index => _index;

  void changeIndex(value) {
    _index = value;
    notifyListeners();
  }

  static double screenHeight() {
    final size = ui.window.physicalSize / ui.window.devicePixelRatio;
    return size.height;
  }

  double maxHeight = 1.0;
  double minHeight = (kToolbarHeight / screenHeight());

  double _value = 0.0;

  double get value => _value;

  void initOffset() {
    _value = (minHeight - minHeight) / (maxHeight - minHeight);
    notifyListeners();
  }

  void changeOffset(value) {
    _value = (value - minHeight) / (maxHeight - minHeight);
    print(_value);
    notifyListeners();
  }
}
