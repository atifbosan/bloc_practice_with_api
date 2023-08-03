import 'package:shared_preferences/shared_preferences.dart';

import 'package:bloc_cfl/app/const/globals.dart';

class LocalDB {
  // late SharedPreferences pref;

  static initiate() async {
    var pref = await SharedPreferences.getInstance();
    Globals.userName = pref.getString("UserName") ?? "";
    Globals.CountryId = pref.getInt("CountryId") ?? 0;
    Globals.Userno = pref.getInt("Userno") ?? 0;
    return Globals.Userno;
  }

  static setData(String key, value) async {
    var pref = await SharedPreferences.getInstance();
    switch (value.runtimeType) {
      case int:
        pref.setInt(key, value);
        break;
      case String:
        pref.setString(key, value);
        break;
      case bool:
        pref.setBool(key, value);
        break;
      case double:
        pref.setDouble(key, value);
        break;
      case List<String>:
        pref.setStringList(key, value);
        break;
    }
  }

  static getData(String key, {type}) async {
    var pref = await SharedPreferences.getInstance();

    if (type != null) {
      return pref.getStringList(key);
    }
    return pref.get(key);
  }

  static clear() async {
    var pref = await SharedPreferences.getInstance();
    bool first = pref.getBool("first") ?? false;
    Globals.userName = '';
    Globals.Userno = 0;
    Globals.authToken = '';
    pref.remove(Globals.authToken);
    // await pref.remove("token");
    // await pref.remove("fullName");
    await pref.clear();

    if (first) {
      pref.setBool("first", true);
    }
  }

/*  Future getDeviceToken() async {
    //request user permission for push notification
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging _firebaseMessage = FirebaseMessaging.instance;
    String? deviceToken = await _firebaseMessage.getToken();
    return (deviceToken == null) ? "" : deviceToken;
  }*/
}
