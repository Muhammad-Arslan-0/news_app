import 'package:news_app/model/local_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefServices {
  static Future setUserToPref(LocalUserModel localUserModel) async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    // var data = localUserModel.toJson();
    // await userPref.setString("localUser", data.toString());
    if (localUserModel.isGuest!) {
      await userPref.setBool("isGuest", localUserModel.isGuest!);
    } else {
      await userPref.setBool("isGuest", localUserModel.isGuest!);
      await userPref.setString("uID", localUserModel.uID!);
    }
  }

  static Future<LocalUserModel?> getUserFromPref() async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    var uID = await userPref.getString("uID");
    var isGuest = await userPref.getBool("isGuest");
    print(uID.toString());
    print(isGuest.toString());

    if (uID != null || isGuest != null) {
      return LocalUserModel(uID: uID, isGuest: isGuest);
    } else {
      return null;
    }
  }

  static Future removeUserFromPref() async {
    SharedPreferences userPref = await SharedPreferences.getInstance();
    await userPref.clear();
  }
}
