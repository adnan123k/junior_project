import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

import '../data.dart';
import '../model/comment.dart';
import 'package:http/http.dart' as http;

class CommentController extends GetxController {
  RxList<Comment> allComments = new List<Comment>().obs;
  RxBool isLoading = false.obs;
  void putLikeOnComment(int id) async {
    try {
      isLoading.value = true;

      await http
          .put(
            Uri.parse(url + putLikeOnCommentUrl + id.toString()),
            headers: headers,
          )
          .timeout(Duration(seconds: 30));

      isLoading.value = false;
    } on SocketException catch (_) {
      isLoading.value = false;
      Get.rawSnackbar(title: "connection", message: "unable to connect");
    }
  }

  void getAllComments(int id) async {
    try {
      isLoading.value = true;

      allComments.clear();
      http.Response temp = await http
          .get(Uri.parse(url + getAllCommentsUrl + id.toString()),
              headers: headers)
          .timeout(Duration(seconds: 30));
      final data = jsonDecode(temp.body);
      if (data.containsKey("data")) {
        for (int i = 0; i < data["data"].length; i++) {
          allComments.add(Comment.fromJson(data["data"][i]));
        }
      }
      isLoading.value = false;
    } on SocketException catch (_) {
      isLoading.value = false;
      Get.rawSnackbar(title: "connection", message: "unable to connect");
    }
  }

  void deleteComment(int id) async {
    try {
      isLoading.value = true;

      await http
          .delete(Uri.parse(url + deleteCommentUrl + id.toString()),
              headers: headers)
          .timeout(Duration(seconds: 30));
      Comment temp;

      allComments.forEach((element) {
        if (element.id == id) temp = element;
      });
      if (allComments.length > 0) allComments.remove(temp);
      isLoading.value = false;
    } on SocketException catch (_) {
      isLoading.value = false;
      Get.rawSnackbar(title: "connection", message: "unable to connect");
    }
  }

  void postComment(int id, String body) async {
    try {
      isLoading.value = true;

      http.Response temp = await http
          .post(Uri.parse(url + postCommentUrl),
              headers: headers,
              body: jsonEncode({"body": body, "discussion_id": id}))
          .timeout(Duration(seconds: 30));

      final data = jsonDecode(temp.body);

      if (data.containsKey("data"))
        allComments.add(Comment.fromJson(data["data"]));

      isLoading.value = false;
    } on SocketException catch (_) {
      isLoading.value = false;
      Get.rawSnackbar(title: "connection", message: "unable to connect");
    }
  }
}
