import 'dart:convert';

import 'package:gogogo/View/Order/Cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false; // Default to false if not set
}

Future<String> getUserName() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getString('username') ?? ''; // Default to false if not set
}
Future<bool> getIsAdmin() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getBool('isAdmin') ?? false; // Default to
}
Future<bool> storeIsAdmin(bool a) async {
  final pref = await SharedPreferences.getInstance();
  
  return pref.setBool('isAdmin', a) ?? false; // Default to
}
Future<void> storeUserLogin(String username) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', true);
  await prefs.setString('username', username);
  // Optionally store other user data (e.g., token)
}

Future<void> storeFireBaseDataUser(
    String? num, String? Proname, String? url) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('Phonenum', num!);
  await prefs.setString('ProName', Proname!);
  await prefs.setString('proURL', url!);
  // Optionally store other user data (e.g., token)
}

Future<String> getPhonenum() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getString('Phonenum') ?? ''; // Default to false if not set
}
Future<String> getProName() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getString('ProName') ?? ''; // Default to false if not set
}
Future<String> getproURL() async {
  final pref = await SharedPreferences.getInstance();
  return pref.getString('proURL') ?? ''; // Default to false if not set
}
// "Phonenum": "${number}",
//                                       "ProName": "${name}",
//                                       "proURL": "${url}",
Future<void> clearUserLogin() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', false);
  await prefs.remove('username');
  await prefs.remove('Phonenum');
  await prefs.remove('ProName');
  await prefs.remove('proURL');
  await prefs.remove('proURL');
  // Remove other stored user data
}


