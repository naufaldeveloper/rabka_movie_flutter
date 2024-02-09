import 'package:flutter/foundation.dart';

class DrawerToggleProvider extends ChangeNotifier {
  bool _toggleValue = false;

  bool get toggleValue => _toggleValue;

  void setToggleValue(bool value) {
    _toggleValue = value;
    notifyListeners();
  }
}
