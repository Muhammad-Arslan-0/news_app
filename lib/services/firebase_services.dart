import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/helper/route_constant.dart';
import 'package:news_app/model/google_auth_model.dart';
import 'package:news_app/services/shared_pref_services.dart';
import 'package:news_app/widgets/toast.dart';

import '../model/auth_model.dart';
import '../model/user_model.dart';

class FirebaseServices {
  static Future<AuthModel> createUserWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return AuthModel(userCredential: userCredential);
    } on FirebaseAuthException catch (exception) {
      return AuthModel(exception: exception);
    }
  }

  static Future<AuthModel> signInUserWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return AuthModel(userCredential: userCredential);
    } on FirebaseAuthException catch (exception) {
      return AuthModel(exception: exception);
    }
  }

  static Future addUserToFirestore(UserModel userModel) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userModel.uID)
        .set(userModel.toJson());
  }

  static Future<GoogleAuthModel> signInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount? account = await _googleSignIn.signIn();
    if (account != null) {
      return GoogleAuthModel(accountData: account);
    } else {
      return GoogleAuthModel(exception: "Login Canceled");
    }
  }

  static Future<UserModel?> getUserFromFirestore(String id) async {
    try {
      DocumentReference<Map<String, dynamic>> documentReference =
          await FirebaseFirestore.instance.collection("users").doc(id);
      var data = await documentReference.get();
      return UserModel.fromJson(data.data());
    } catch (exception) {
      return null;
    }
  }

  static Future signOutUser(BuildContext context) async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.signOut();
    await FirebaseAuth.instance.signOut().whenComplete(() async {
      await SharedPrefServices.removeUserFromPref();
      GoRouter.of(context).goNamed(RouteConstant.signInScreen);
    }).onError((error, stackTrace) {
      toast(true, error.toString());
    });
  }
}
