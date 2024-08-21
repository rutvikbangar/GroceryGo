import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
 static String userLoggedInKey = "USERLOGGEDINKEY";
 static String userNameKey = "USERNAMEKEY";
 static String userEmailKey = "USEREMAILKEY";

 // saving user status in shared preferences in key : value pair

 static Future<bool> saveUserLogInStatus (bool isuserLogIn)async {
   SharedPreferences sf = await SharedPreferences.getInstance();
   return await sf.setBool(userLoggedInKey,isuserLogIn);
 }
 static Future<bool> saveUserNamewStatus(String fullname) async {
   SharedPreferences sf = await SharedPreferences.getInstance();
   return await sf.setString(userNameKey, fullname);
 }
 static Future<bool> saveUserEmailStatus(String email) async {
   SharedPreferences sf = await SharedPreferences.getInstance();
   return await sf.setString(userEmailKey, email);
 }
 // getting data from shared preferences

 static Future<bool?> getUserLogInStatus ()async {
   SharedPreferences sf = await SharedPreferences.getInstance();
   return await sf.getBool(userLoggedInKey);
 }
 static Future<String?> getUserNamewStatus() async {
   SharedPreferences sf = await SharedPreferences.getInstance();
   return await sf.getString(userNameKey);
 }
 static Future<String?> getUserEmailStatus() async {
   SharedPreferences sf = await SharedPreferences.getInstance();
   return await sf.getString(userEmailKey);
 }

}