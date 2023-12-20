import 'package:flutter/material.dart';

class OnBoardProvider extends ChangeNotifier {
  int _currentVerticalPage = 0;
  int get currentVerticalPage => _currentVerticalPage;

  void changeVerticalIndex(int index) {
    _currentVerticalPage = index;
    notifyListeners();
  }
}
