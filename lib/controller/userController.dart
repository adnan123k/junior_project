import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:junior_project/controller/authController.dart';
import 'package:junior_project/data.dart';
import 'package:junior_project/model/question.dart';
import 'package:junior_project/model/user.dart';
import 'package:http/http.dart' as http;

class UserController extends AuthController {
  RxList<User> topStudent = new List<User>().obs;

  void updatePoint(int point) async {
    if (currentUser.value.type == "student") {
      try {
        isLoading.value = true;

        http.Response temp = await http
            .patch(Uri.parse(url + updatePointurl),
                headers: headers, body: jsonEncode({"points": point}))
            .timeout(Duration(seconds: 30));
        final data = jsonDecode(temp.body);
        if (data.containsKey("data")) {
          currentUser.value.points += point;
          final tmp = await localData;
          tmp.setInt("point", currentUser.value.points);
        }
        isLoading.value = false;
      } on SocketException catch (_) {
        isLoading.value = false;
        Get.rawSnackbar(title: "connection", message: "unable to connect");
      }
    }
  }

  void getTop10Student() async {
    try {
      isLoading.value = true;

      topStudent.clear();
      http.Response temp = await http
          .get(Uri.parse(url + top10StudentUrl), headers: headers)
          .timeout(Duration(seconds: 30));
      final data = jsonDecode(temp.body);
      if (data.containsKey("data")) {
        for (int i = 0; i < data["data"].length; i++) {
          topStudent.add(User.fromJson2(data["data"][i]));
        }
        isLoading.value = false;
      } else {
        signOut();
      }
    } on SocketException catch (_) {
      isLoading.value = false;
      Get.rawSnackbar(title: "connection", message: "unable to connect");
    }
  }

  RxList<User> teachers = new List<User>().obs;
  void getTeacher() async {
    try {
      isLoading.value = true;

      teachers.clear();
      http.Response temp = await http
          .get(Uri.parse(url + getAllTeacher), headers: headers)
          .timeout(Duration(seconds: 30));
      final data = jsonDecode(temp.body);
      if (data.containsKey("data")) {
        for (int i = 0; i < data["data"].length; i++) {
          teachers.add(User.fromJson3(data["data"][i]));
        }
      }
      isLoading.value = false;
    } on SocketException catch (_) {
      isLoading.value = false;
      Get.rawSnackbar(title: "connection", message: "unable to connect");
    }
  }

  Future<bool> blockUser(int id) async {
    try {
      isLoading.value = true;

      http.Response temp = await http
          .patch(Uri.parse(url + blockUserUrl + id.toString()),
              headers: headers)
          .timeout(Duration(seconds: 30));
      Map<String, dynamic> data = jsonDecode(temp.body);
      if (data.containsKey("data") && data["data"]) {
        isLoading.value = false;

        return true;
      } else {
        isLoading.value = false;

        return false;
      }
    } on SocketException catch (_) {
      isLoading.value = false;
      Get.rawSnackbar(title: "connection", message: "unable to connect");
    }
  }

  Future<Map<String, dynamic>> addTeacher(
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
          .post(Uri.parse(url + addTeacherUrl),
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
      if (data.containsKey("data")) {
        teachers.add(User.fromJson3(data["data"]));
        msg = "added";
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

  Future<Map<String, dynamic>> putTeacher(
      {String username,
      String password,
      String fullName,
      String motherName,
      String fatherName,
      int id}) async {
    try {
      isLoading.value = true;

      String msg = "";
      bool error = true;
      http.Response temp = await http
          .put(Uri.parse(url + putTeacherUrl + id.toString()),
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
      if (data.containsKey("data")) {
        msg = "added";
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

  void deleteTeacher({int id}) async {
    try {
      isLoading.value = true;

      http.Response temp = await http
          .delete(Uri.parse(url + deleteTeacherUrl + id.toString()),
              headers: headers)
          .timeout(Duration(seconds: 30));
      final data = jsonDecode(temp.body);
      if (data.containsKey("data")) {
        User t;
        teachers.forEach((element) {
          if (element.id == id) {
            t = element;
          }
        });
        teachers.remove(t);
      }
      isLoading.value = false;
    } on SocketException catch (_) {
      isLoading.value = false;
      Get.rawSnackbar(title: "connection", message: "unable to connect");
    }
  }

  void postUserAttemp({List<Question> questions}) async {
    try {
      if (currentUser.value.type == "student") {
        isLoading.value = true;

        List<Map<String, dynamic>> temp = new List<Map<String, dynamic>>();
        questions.forEach((element) {
          temp.add(element.toJson());
        });
        http.Response res = await http
            .post(Uri.parse(url + postQuestionAttempUrl),
                headers: headers, body: jsonEncode({"questions": temp}))
            .timeout(Duration(seconds: 30));

        isLoading.value = false;
      }
    } on SocketException catch (_) {
      isLoading.value = false;
      Get.rawSnackbar(title: "connection", message: "unable to connect");
    }
  }
}
