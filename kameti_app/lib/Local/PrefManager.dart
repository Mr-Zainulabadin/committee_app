import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {
  late SharedPreferences sp;

  init() async {
    sp = await SharedPreferences.getInstance();
  }

  Future<bool> saveUser() async {
    await init();
    return sp.setInt(Pref.isLoggedIn, 1);
  }

  Future<bool> isLoggedIn() async {
    await init();
    int isLoggedIn = sp.getInt(Pref.isLoggedIn) ?? 0;
    return isLoggedIn == 1 ? true : false;
  }

  Future<bool> isFirstTime() async {
    await init();
    return sp.getBool(Pref.firstTime) ?? true;
  }

  Future<bool> setLoggedIn() async {
    await init();
    return sp.setInt(Pref.isLoggedIn, 1);
  }

  Future<bool> setFirstTime() async {
    await init();
    return sp.setBool(Pref.firstTime, false);
  }

  Future<bool> signOut() async {
    await init();
    return sp.clear();
  }

  // for saving all vpn servers
}

class Pref {
  static String isLoggedIn = "isLoggedIn";
  static String userData = "userData";
  static String firstTime = "isFirstTime";
}
