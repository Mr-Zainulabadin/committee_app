import 'package:flutter/widgets.dart';

class BottomNavProvider extends ChangeNotifier {
  static int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void changeSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
