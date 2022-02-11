import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

import '../data.dart';
import '../model/discussion.dart';
import 'package:http/http.dart' as http;

class DiscussionContoller extends GetxController {
  RxList<Discussion> userDiscussions = new List<Discussion>().obs;
  RxList<Discussion> allDiscussions = new List<Discussion>().obs;
  RxBool isLoading = false.obs;
  void getUserDiscussion() async {
    try {
      isLoading.value = true;

      userDiscussions.clear();
      http.Response temp = await http
          .get(Uri.parse(url + getUserDisscusionUrl), headers: headers)
          .timeout(Duration(seconds: 30));
      final data = jsonDecode(temp.body);
      if (data.containsKey("data")) {
        for (int i = 0; i < data["data"].length; i++) {
          userDiscussions.add(Discussion.fromJson(data["data"][i]));
        }
      }
      isLoading.value = false;
    } on SocketException catch (_) {
      isLoading.value = false;
      Get.rawSnackbar(title: "connection", message: "unable to connect");
    }
  }

  void putLikeOnDiscussion(int id) async {
    try {
      isLoading.value = true;

      await http
          .put(
            Uri.parse(url + putLikeOnDiscussionUrl + id.toString()),
            headers: headers,
          )
          .timeout(Duration(seconds: 30));

      isLoading.value = false;
    } on SocketException catch (_) {
      isLoading.value = false;
      Get.rawSnackbar(title: "connection", message: "unable to connect");
    }
  }

  void deleteDiscussion(int id) async {
    try {
      isLoading.value = true;

      http.Response temp = await http
          .delete(Uri.parse(url + deleteDisscusionUrl + id.toString()),
              headers: headers)
          .timeout(Duration(seconds: 30));
      Discussion t;
      final data = jsonDecode(temp.body);

      if (data.containsKey("data") && data["data"] != 0) {
        userDiscussions.forEach((element) {
          if (element.id == id) t = element;
        });

        if (temp != null) userDiscussions.remove(temp);
        allDiscussions.forEach((element) {
          if (element.id == id) t = element;
        });
        if (allDiscussions.length > 0) allDiscussions.remove(temp);
      }
      isLoading.value = false;
    } on SocketException catch (_) {
      isLoading.value = false;
      Get.rawSnackbar(title: "connection", message: "unable to connect");
    }
  }

  void postDiscussion(int id, String body) async {
    try {
      isLoading.value = true;

      http.Response temp = await http
          .post(Uri.parse(url + postDiscussionUrl),
              headers: headers,
              body: jsonEncode({"body": body, "video_id": id}))
          .timeout(Duration(seconds: 30));
      final data = jsonDecode(temp.body);
      if (data.containsKey("data")) {
        allDiscussions.add(Discussion.fromJson(data["data"]));
        userDiscussions.add(Discussion.fromJson(data["data"]));
      }

      isLoading.value = false;
    } on SocketException catch (_) {
      isLoading.value = false;
      Get.rawSnackbar(title: "connection", message: "unable to connect");
    }
  }

  void getAllDiscussion(int id) async {
    try {
      isLoading.value = true;

      allDiscussions.clear();
      http.Response temp = await http
          .get(Uri.parse(url + getAllDisscusionUrl + id.toString()),
              headers: headers)
          .timeout(Duration(seconds: 30));
      final data = jsonDecode(temp.body);
      if (data.containsKey("data")) {
        for (int i = 0; i < data["data"].length; i++) {
          allDiscussions.add(Discussion.fromJson(data["data"][i]));
        }
      }
      isLoading.value = false;
    } on SocketException catch (_) {
      isLoading.value = false;
      Get.rawSnackbar(title: "connection", message: "unable to connect");
    }
  }
}
