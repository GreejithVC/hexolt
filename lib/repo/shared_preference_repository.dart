import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceRepository {
  static const String KEY_TOKEN = "KEY_TOKEN";

  static Future<void> setToken(String token) async {
    debugPrint("token -- $token");
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(KEY_TOKEN, token);
  }

  static Future<String> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString(KEY_TOKEN) ?? "";
    return token;
  }
}
