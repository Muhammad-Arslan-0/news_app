import 'package:firebase_auth/firebase_auth.dart';

class AuthModel {
  UserCredential? userCredential;
  FirebaseAuthException? exception;

  AuthModel({this.userCredential, this.exception});
}
