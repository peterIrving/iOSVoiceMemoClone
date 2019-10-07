import 'package:flutter/material.dart';

class RecordingListProvider with ChangeNotifier {

  int _selectedIndex = -1;

  // TODO add logic to manage which tile is expanded or not

  int get selectedIndex {
    return _selectedIndex;
  }

  set setSelectedIndex(int selectedIndex) {
    _selectedIndex = selectedIndex;
    notifyListeners();
  }

}