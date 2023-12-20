import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthModel {
  final GoogleSignInAccount? accountData;
  final String? exception;
  GoogleAuthModel({this.accountData, this.exception});
}
