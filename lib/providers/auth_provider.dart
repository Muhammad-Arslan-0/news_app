import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/providers/dashboard_provider.dart';
import 'package:provider/provider.dart';

import '../helper/route_constant.dart';
import '../main.dart';
import '../model/local_user_model.dart';
import '../model/user_model.dart';
import '../services/firebase_services.dart';
import '../services/shared_pref_services.dart';
import '../widgets/toast.dart';
import 'favorite_topic_provider.dart';

class AuthProvider extends ChangeNotifier {
  bool _isSignInLoading = false;
  bool get isSignInLoading => _isSignInLoading;
  bool _isSignUpLoading = false;
  bool get isSignUpLoading => _isSignUpLoading;

  final TextEditingController _emailSignInController = TextEditingController();
  final TextEditingController _passwordSignInController =
      TextEditingController();
  final _signInformKey = GlobalKey<FormState>();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailSignUpController = TextEditingController();
  final TextEditingController _passwordSignUpController =
      TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final _signUpFormKey = GlobalKey<FormState>();

  TextEditingController get emailSignInController => _emailSignInController;
  TextEditingController get passwordSignInController =>
      _passwordSignInController;
  GlobalKey<FormState> get signInFormKey => _signInformKey;

  TextEditingController get usernameController => _usernameController;
  TextEditingController get emailSignUpController => _emailSignUpController;
  TextEditingController get passwordSignUpController =>
      _passwordSignUpController;
  TextEditingController get rePasswordController => _rePasswordController;
  GlobalKey<FormState> get signUpFormKey => _signUpFormKey;

  setSignInLoading(bool value) {
    _isSignInLoading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _isSignUpLoading = value;
    notifyListeners();
  }

  clearSignUpFields() {
    _usernameController.clear();
    _emailSignUpController.clear();
    _passwordSignUpController.clear();
    _rePasswordController.clear();
  }

  clearSignInFields() {
    _emailSignInController.clear();
    _passwordSignInController.clear();
  }

  Future signUpWithEmail(context) async {
    if (_passwordSignUpController.text == _rePasswordController.text) {
      FocusScope.of(context).unfocus();
      setSignUpLoading(true);
      FirebaseServices.createUserWithEmailPassword(
              _emailSignUpController.text, _passwordSignUpController.text)
          .then((authModel) {
        if (authModel.userCredential != null) {
          UserModel userModel = UserModel(
              userName: _usernameController.text,
              emailAddress: _emailSignUpController.text,
              uID: authModel.userCredential!.user!.uid,
              fvTopics: [],
              savedNews: []);
          FirebaseServices.addUserToFirestore(userModel).whenComplete(() {
            setSignUpLoading(false);
            toast(false, "Successfully Register");
            clearSignUpFields();
            Provider.of<FavoriteTopicProvider>(context, listen: false)
                .selectedTopics
                .clear();
            GoRouter.of(context).pushNamed(RouteConstant.favoriteTopicScreen,
                extra: [userModel, false]);
          }).onError((error, stackTrace) {
            setSignUpLoading(false);
            toast(true, "Something went wrong");
          });
        } else {
          setSignUpLoading(false);
          toast(true, authModel.exception!.message!.toString());
        }
      });
    } else {
      toast(true, "Repeat Password doesn't match");
    }
  }

  Future signInWithEmail(context) async {
    FocusScope.of(context).unfocus();
    setSignInLoading(true);
    FirebaseServices.signInUserWithEmailPassword(
            _emailSignInController.text, _passwordSignInController.text)
        .then((authModel) {
      setSignInLoading(false);
      if (authModel.userCredential != null) {
        toast(false, "Successfully Login");
        clearSignInFields();
        localUser = LocalUserModel(
            isGuest: false, uID: authModel.userCredential!.user!.uid);
        SharedPrefServices.setUserToPref(LocalUserModel(
            isGuest: false, uID: authModel.userCredential!.user!.uid));
        Provider.of<DashboardProvider>(context, listen: false).changeIndex(0);
        GoRouter.of(context).goNamed(RouteConstant.dashBoardScreen);
      } else {
        String msg = switch (authModel.exception!.code) {
          "INVALID_LOGIN_CREDENTIALS" => "Password or email doesn't match",
          (String()) => "Something Went Wrong",
        };
        toast(true, msg);
      }
    });
  }

  Future signInWithGoogle(context) async {
    FocusScope.of(context).unfocus();
    FirebaseServices.signInWithGoogle().then((googleAuth) {
      if (googleAuth.accountData != null) {
        FirebaseFirestore.instance
            .collection("users")
            .where("uID", isEqualTo: googleAuth.accountData!.id)
            .get()
            .then((value2) {
          if (value2.size == 0) {
            UserModel userModel = UserModel(
                userName: googleAuth.accountData!.displayName ?? "",
                emailAddress: googleAuth.accountData!.email,
                uID: googleAuth.accountData!.id,
                fvTopics: [],
                savedNews: []);
            FirebaseServices.addUserToFirestore(userModel).whenComplete(() {
              toast(false, "Successfully Register");
              GoRouter.of(context).pushNamed(RouteConstant.favoriteTopicScreen,
                  extra: [userModel, true]);
            }).onError((error, stackTrace) {
              toast(true, "Something went wrong");
            });
          } else {
            localUser =
                LocalUserModel(isGuest: false, uID: googleAuth.accountData!.id);
            SharedPrefServices.setUserToPref(LocalUserModel(
                isGuest: false, uID: googleAuth.accountData!.id));
            Provider.of<DashboardProvider>(context, listen: false)
                .changeIndex(0);
            GoRouter.of(context).goNamed(RouteConstant.dashBoardScreen);
          }
        });
      } else {
        toast(true, googleAuth.exception!);
      }
    });
  }
}
