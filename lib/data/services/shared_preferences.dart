import 'dart:convert';
import 'dart:developer';

import 'package:imgur/models/ModelProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  final String userPath = 'userDetails';
  final String tokenPath = 'token';

  saveUser(UserModel user) async {
    final _prefs = await SharedPreferences.getInstance();
    final value = jsonEncode(user.toJson());
    _prefs.setString(userPath, value);
  }

  Future<UserModel?> readUser() async {
    final _prefs = await SharedPreferences.getInstance();
    final value = _prefs.getString(userPath);
    if (value != null) {
      final user = UserModel.fromJson(jsonDecode(value));
      return user;
    }
    return null;
  }

  saveToken(String token) async {
    final _prefs = await SharedPreferences.getInstance();
    final validTime = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day + 29);

    final Map<String, dynamic> map = {
      'token': token,
      'validity': validTime.millisecondsSinceEpoch
    };
    _prefs.setString(tokenPath, jsonEncode(map));
  }

  Future<String?> readToken() async {
    final _prefs = await SharedPreferences.getInstance();
    final value = _prefs.getString(tokenPath);
    if (value != null) {
      final Map<String, dynamic> token = jsonDecode(value);
      final validity = token['validity'];
      final diff = DateTime.fromMillisecondsSinceEpoch(validity);
      final res = diff.compareTo(DateTime.now());
      if (res > 0) {
        return token['token'];
      }
    }
    return null;
  }
}
