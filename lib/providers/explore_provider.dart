import 'package:flutter/material.dart';

class ExploreProvider extends ChangeNotifier {
  String _keyword = "";
  String get keyword => _keyword;

  changeKeyword(String keyword) {
    _keyword = keyword;
    notifyListeners();
  }
}
