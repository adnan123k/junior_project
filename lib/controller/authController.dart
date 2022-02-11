import 'dart:convert';
import 'dart:io';

import '../data.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<User> currentUser = null.obs;
  Future<SharedPreferences> localData = SharedPreferences.getInstance();
  RxBool isLogin = false.obs;

  void initalize() async {
    isLoading.value = true;

    SharedPreferences _localData = await localData;
    if (_localData.containsKey("username")) {
      currentUser = Rx<User>(User(
          _localData.getInt("id"),
          _localData.getString("username"),
          _localData.getString("token"),
          _localData.getString("type"),
          _localData.getInt("point"),
          _localData.getString("mother_name"),
          _localData.getString("father_name")));
      headers["Authorization"] = currentUser.value.token;
      isLogin.value = true;
    }
    isLoading.value = false;
  }

  Future<Map<String, dynamic>> signIn(
      {String username, String password}) async {
    try {
      isLoading.value = true;

      String msg = "";
      bool error = true;

      http.Response temp = await http
          .post(Uri.parse(url + logIn),
              headers: headers,
              body: jsonEncode({"username": username, "password": password}))
          .catchError((onError) {
        msg = "check your connection and try again";
      }).timeout(Duration(seconds: 30));
      var data = null;
      if (msg == "") {
        data = jsonDecode(temp.body);
        if (data.containsKey("token")) {
          currentUser = Rx<User>(User.fromJson(data));
          isLogin.value = true;
          SharedPreferences _localData = await localData;
          _localData.setInt("id", currentUser.value.id);
          _localData.setString("token", currentUser.value.token);
          _localData.setString("type", currentUser.value.type);
          _localData.setString("username", currentUser.value.userName);
          _localData.setString("mother_name", currentUser.value.motherName);
          _localData.setString("father_name", currentUser.value.fatherName);
          _localData.setInt("point", currentUser.value.points);
          headers["Authorization"] = currentUser.value.token;
          msg = "welcome";
          error = false;
        }
        msg = data["message"];
      }
      isLoading.value = false;

      return {
        "error": error,
        "msg": msg,
        "errors": data == null ? Map<String, dynamic>() : data["errors"]
      };
    } on SocketException catch (_) {
      isLoading.value = false;
      Get.rawSnackbar(title: "connection", message: "unable to connect");
      return {"error": true, "msg": "no connection", "errors": null};
    }
  }

  void signOut() async {
    try {
      isLoading.value = true;

      http.Response temp = await http
          .post(
            Uri.parse(url + logOut),
            headers: headers,
          )
          .timeout(Duration(seconds: 30));

      currentUser = null;
      SharedPreferences _localData = await localData;
      _localData.remove("id");
      _localData.remove("token");
      _localData.remove("username");
      _localData.remove("type");
      _localData.remove("point");
      headers.remove("Authorization");
      isLogin.value = false;

      isLoading.value = false;
    } on SocketException catch (_) {
      isLoading.value = false;
      Get.rawSnackbar(title: "connection", message: "unable to connect");
    }
  }

  Future<Map<String, dynamic>> sign_up(
      {String username,
      String password,
      String fullName,
      String motherName,
      String fatherName}) async {
    try {
      isLoading.value = true;

      String msg = "";
      bool error = true;
      http.Response temp = await http
          .post(Uri.parse(url + signUp),
              headers: headers,
              body: jsonEncode({
                "username": username,
                "password": password,
                "full_name": fullName,
                "mother_name": motherName,
                "father_name": fatherName
              }))
          .timeout(Duration(seconds: 30));

      final data = jsonDecode(temp.body);
      if (data.containsKey("token")) {
        currentUser = Rx<User>(User.fromJson(data));
        isLogin.value = true;
        SharedPreferences _localData = await localData;
        _localData.setInt("id", currentUser.value.id);
        _localData.setString("token", currentUser.value.token);
        _localData.setString("type", currentUser.value.type);
        _localData.setString("username", currentUser.value.userName);
        _localData.setString("mother_name", currentUser.value.motherName);
        _localData.setString("father_name", currentUser.value.fatherName);
        _localData.setInt("point", currentUser.value.points);
        headers["Authorization"] = currentUser.value.token;
        msg = "welcome";
        error = false;
      }
      msg = data["message"];

      isLoading.value = false;

      return {"error": error, "msg": msg, "errors": data["errors"]};
    } on SocketException catch (_) {
      isLoading.value = false;
      Get.rawSnackbar(title: "connection", message: "unable to connect");
      return {"error": true, "msg": "no connection", "errors": null};
    }
  }
}
