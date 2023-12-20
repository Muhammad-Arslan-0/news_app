import 'package:flutter/material.dart';
import 'package:news_app/views/dashboard/explore/explore_screen.dart';
import 'package:news_app/views/dashboard/home/home_screen.dart';
import 'package:news_app/views/dashboard/profile/profile_screen.dart';
import 'package:news_app/views/dashboard/saved_news/save_news_screen.dart';
import 'package:news_app/views/dashboard/trending/trending_screen.dart';
import 'package:news_app/widgets/toast.dart';

import '../services/firebase_services.dart';

class DashboardProvider extends ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLogoutLoading = false;
  bool get isLogoutLoading => _isLogoutLoading;

  // List screens = [
  //   HomeScreen(),
  //   ExploreScreen(),
  //   TrendingScreen(),
  //   if (!localUser!.isGuest!) SaveNewsScreen(),
  //   ProfileScreen()
  // ];
  List screensWithSave = [
    HomeScreen(),
    ExploreScreen(),
    TrendingScreen(),
    SaveNewsScreen(),
    ProfileScreen()
  ];
  List screensWithOutSave = [
    HomeScreen(),
    ExploreScreen(),
    TrendingScreen(),
    ProfileScreen()
  ];

  changeIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  logOutBtnPressed(context) {
    _isLogoutLoading = true;
    notifyListeners();
    FirebaseServices.signOutUser(context).onError((error, stackTrace) {
      _isLogoutLoading = false;
      notifyListeners();
      toast(true, error.toString());
    }).whenComplete(() {
      _isLogoutLoading = false;
      notifyListeners();
    });
  }
}
