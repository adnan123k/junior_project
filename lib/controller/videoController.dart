import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../data.dart';
import '../model/video.dart';

class VideoController extends GetxController {
  RxBool isLoading = false.obs;
  Future<bool> addVideo(
      File video, String title, String description, int id) async {
    try {
      isLoading.value = true;

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url + addVideoUrl),
      );

      request.files.add(
        http.MultipartFile(
          'video',
          video.readAsBytes().asStream(),
          video.lengthSync(),
          filename: DateTime.now().toString() + title,
        ),
      );
      request.fields.addAll({
        "title": title,
        "description": description,
        "lesson_id": id.toString(),
      });
      request.headers.addAll(headers);

      var res = await request.send().timeout(Duration(seconds: 30));

      final respStr = await res.stream.bytesToString();

      Map<String, dynamic> data = jsonDecode(respStr);
      print(data);
      if (data.containsKey("data")) {
        isLoading.value = false;

        return true;
      }
      isLoading.value = false;
    } on SocketException catch (_) {
      isLoading.value = false;
      Get.rawSnackbar(title: "connection", message: "unable to connect");
    }

    return false;
  }

  Future<bool> putVideo(
      {File video,
      String title,
      String description,
      int id,
      int videoId}) async {
    try {
      isLoading.value = true;

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url + putVideoUrl + videoId.toString()),
      );
      if (video != null) {
        request.files.add(
          http.MultipartFile(
            'video',
            video.readAsBytes().asStream(),
            video.lengthSync(),
            filename: DateTime.now().toString() + title,
          ),
        );
      }
      request.fields.addAll({
        "title": title,
        "description": description,
        "lesson_id": id.toString(),
        '_method': 'PUT'
      });
      request.headers.addAll(headers);

      var res = await request.send().timeout(Duration(seconds: 30));

      final respStr = await res.stream.bytesToString();

      Map<String, dynamic> data = jsonDecode(respStr);
      print(data);
      if (data.containsKey("data")) {
        lessonVideos.clear();
        getLessonVideos(id);
        isLoading.value = false;

        return true;
      }
      isLoading.value = false;
    } on SocketException catch (_) {
      isLoading.value = false;
      Get.rawSnackbar(title: "connection", message: "unable to connect");
    }

    return false;
  }

  RxList<Video> lessonVideos = new List<Video>().obs;
  void getLessonVideos(int id) async {
    try {
      isLoading.value = true;

      lessonVideos.clear();
      http.Response temp = await http
          .get(Uri.parse(url + getLessonVideo + id.toString()),
              headers: headers)
          .timeout(Duration(seconds: 30));
      final data = jsonDecode(temp.body);

      if (data.containsKey("data")) {
        for (int i = 0; i < data["data"].length; i++) {
          lessonVideos.add(Video.fromJson(data["data"][i]));
        }
      }
      isLoading.value = false;
    } on SocketException catch (_) {
      isLoading.value = false;
      Get.rawSnackbar(title: "connection", message: "unable to connect");
    }
  }

  void deleteVideo(int index) async {
    try {
      isLoading.value = true;

      http.Response temp = await http
          .delete(
              Uri.parse(
                  url + deleteVideoUrl + lessonVideos[index].id.toString()),
              headers: headers)
          .timeout(Duration(seconds: 30));

      Map<String, dynamic> data = jsonDecode(temp.body);

      if (data.containsKey("data") && data["data"]) {
        lessonVideos.removeAt(index);
      }
      isLoading.value = false;
    } on SocketException catch (_) {
      isLoading.value = false;
      Get.rawSnackbar(title: "connection", message: "unable to connect");
    }
  }
}
