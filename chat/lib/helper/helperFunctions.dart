import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String sharedPrefernceUserLoggedKey = "ISLOGGEDIN";
  static String sharedPrefrenceUserNamekey = "USERNAMEKEY";
  static String sharedPrefrenceUserEmailKey = "USEREMAILKEY";

  static Future<void> saveUserLoggedInSharedPrefrence(
      bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPrefernceUserLoggedKey, isUserLoggedIn);
  }

  static Future<void> saveUserNameSharedPrefrence(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPrefrenceUserNamekey, userName);
  }

  static Future<void> saveUserEmailSharedPrefrence(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPrefrenceUserEmailKey, userEmail);
  }

  static Future<bool> getUserLoggedInSharedPrefrence() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPrefernceUserLoggedKey);
  }

  static Future<String> getUserNameSharedPrefrence() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPrefrenceUserNamekey);
  }

  static Future<String> getUserEmailSharedPrefrence() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPrefrenceUserEmailKey);
  }
}
