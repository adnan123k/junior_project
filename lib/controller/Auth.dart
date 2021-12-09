import 'dart:convert';

import 'package:flutter/material.dart';
import '../data.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';

class AuthController extends ChangeNotifier {
  static bool isLoading = false;
  static User currentUser = null;
  static Future<SharedPreferences> localData = SharedPreferences.getInstance();
  static PublishSubject<bool> isLogin;

  void initalize() async {
    isLoading = true;
    notifyListeners();
    SharedPreferences _localData = await localData;
    if (_localData.containsKey("username")) {
      currentUser = User(
          _localData.getString("username"),
          _localData.getString("token"),
          _localData.getString("type"),
          _localData.getInt("point"));
      headers["token"] = currentUser.token;
      isLogin.add(true);
    }
    isLoading = false;
    notifyListeners();
  }

  Future<Map<String, dynamic>> signIn(
      {String username, String password, String type}) async {
    isLoading = true;
    notifyListeners();
    String msg = "";
    bool error = true;
    http.Response temp = await http.post(Uri.parse(url + logIn),
        headers: headers,
        body: jsonEncode(
            {"username": username, "password": password, "type": type}));

    final data = jsonDecode(temp.body);
    if (data.containsKey("token")) {
      currentUser = User.fromJson(data);
      isLogin.add(true);
      SharedPreferences _localData = await localData;
      _localData.setString("token", currentUser.token);
      _localData.setString("type", currentUser.type);
      _localData.setString("username", currentUser.userName);
      _localData.setInt("point", currentUser.points);
      headers["token"] = currentUser.token;
      msg = "welcome";
      error = false;
    }
    msg = data["message"];
    isLoading = false;
    notifyListeners();
    return {"error": error, "msg": msg};
  }

  void signOut() async {
    isLoading = true;
    notifyListeners();

    http.Response temp = await http.post(
      Uri.parse(url + logOut),
      headers: headers,
    );
    if (jsonDecode(temp.body).containsKey("message")) {
      currentUser = null;
      SharedPreferences _localData = await localData;
      _localData.remove("token");
      _localData.remove("username");
      _localData.remove("type");
      _localData.remove("point");
      headers.remove("token");
      isLogin.add(false);
    }
    isLoading = false;
    notifyListeners();
  }
}
