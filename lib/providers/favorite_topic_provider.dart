import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../helper/route_constant.dart';
import '../main.dart';
import '../model/local_user_model.dart';
import '../model/user_model.dart';
import '../services/shared_pref_services.dart';
import '../widgets/toast.dart';
import 'dashboard_provider.dart';

class FavoriteTopicProvider extends ChangeNotifier {
  List<String> _selectedTopics = [];
  List<String> get selectedTopics => _selectedTopics;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  selectTopic(String topic) {
    if (_selectedTopics.contains(topic)) {
      _selectedTopics.remove(topic);
    } else {
      _selectedTopics.add(topic);
    }
    notifyListeners();
  }

  submitTopics(UserModel userModel, context, bool isFromGoogle) {
    setLoading(true);
    UserModel newUserModel = userModel;
    newUserModel.fvTopics = selectedTopics;
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel.uID)
        .set(newUserModel.toJson())
        .whenComplete(() {
      setLoading(false);
      if (isFromGoogle) {
        localUser = LocalUserModel(isGuest: false, uID: userModel.uID);
        SharedPrefServices.setUserToPref(
            LocalUserModel(isGuest: false, uID: userModel.uID));
        Provider.of<DashboardProvider>(context, listen: false).changeIndex(0);
        GoRouter.of(context).goNamed(RouteConstant.dashBoardScreen);
      } else {
        GoRouter.of(context).goNamed(RouteConstant.signInScreen);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      toast(true, "Something Went Wrong");
    });
  }
}
