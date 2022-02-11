import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

import 'package:tflite_flutter/tflite_flutter.dart' as tfl;

import '../data.dart';
import '../model/level.dart';
import '../model/question.dart';
import 'package:http/http.dart' as http;

import '../model/quiz.dart';
import '../model/subject.dart';

class LevelController extends GetxController {
  RxBool isLoading = false.obs;

  void postQuestions({int id, int subjectId, List<Question> questions}) async {
    try {
      isLoading.value = true;

      List<Map<String, dynamic>> temp = new List<Map<String, dynamic>>();
      questions.forEach((element) {
        temp.add(element.toJson());
      });
      await http
          .post(Uri.parse(url + addQuestionUrl + id.toString()),
              headers: headers,
              body: jsonEncode({"subject_id": subjectId, "questions": temp}))
          .timeout(Duration(seconds: 30));

      isLoading.value = false;
    } on SocketException catch (_) {
      isLoading.value = false;
      Get.rawSnackbar(title: "connection", message: "unable to connect");
    }
  }

  RxList<Level> levels = new List<Level>().obs;
  void postUserLevel({int id, int subjectId}) async {
    try {
      isLoading.value = true;

      if (id != 0) {
        http.Response temp = await http
            .post(Uri.parse(url + postUserLevelUrl + id.toString()),
                headers: headers, body: jsonEncode({"subject_id": subjectId}))
            .timeout(Duration(seconds: 30));
        final data = jsonDecode(temp.body);
        if (data.containsKey("data")) {
          levels.forEach((element) {
            if (element.id == id) {
              element.passed = true;
            }
          });
        }
      }

      isLoading.value = false;
    } on SocketException catch (_) {
      isLoading.value = false;
      Get.rawSnackbar(title: "connection", message: "unable to connect");
    }
  }

  void getLevels(int id) async {
    try {
      isLoading.value = true;

      levels.clear();
      http.Response temp = await http
          .get(Uri.parse(url + getLevelsUrl + id.toString()), headers: headers)
          .timeout(Duration(seconds: 30));
      var data = jsonDecode(temp.body);
      if (data.containsKey("data")) {
        for (int i = 0; i < data["data"].length; i++) {
          levels.add(Level.fromJson(data["data"][i]));
        }
      }
      if (levels.isNotEmpty) {
        final interpreter =
            await tfl.Interpreter.fromAsset('junior_model.tflite');

        int index = levels[0].id + 2;
        int index2 = 1;
        List<Quiz> quizes = new List<Quiz>();
        temp = await http
            .get(Uri.parse(url + getQuiz + id.toString()), headers: headers)
            .timeout(Duration(seconds: 30));
        data = jsonDecode(temp.body);
        if (data.containsKey("data")) {
          for (int i = 0; i < data["data"].length; i++) {
            quizes.add(Quiz.fromJson(data["data"][i]));
          }
          do {
            String title = "quiz " + index2.toString();
            int easy = 2;
            int medium = 6;
            int hard = 2;
            List<Question> q = new List<Question>();
            for (int i = 0; i < quizes.length; i++) {
              if (quizes[i].levelId <= index) {
                var input = [
                  [quizes[i].attemp.toDouble(), quizes[i].points.toDouble()]
                ];
                var output = List.filled(1 * 3, 0).reshape([1, 3]);

                interpreter.run(input, output);
                if (output[0][0] > output[0][1] &&
                    output[0][0] > output[0][2] &&
                    easy != 0) {
                  easy--;
                  q.add(quizes[i]);
                } else if (output[0][0] < output[0][1] &&
                    output[0][1] > output[0][2] &&
                    medium != 0) {
                  medium--;
                  q.add(quizes[i]);
                } else if (output[0][0] < output[0][2] &&
                    output[0][1] < output[0][2] &&
                    hard != 0) {
                  hard--;
                  q.add(quizes[i]);
                }
              }
            }
            if (q.length != 10) {
              for (int i = 0; i < quizes.length; i++) {
                if (!q.contains(quizes[i]) && quizes[i].levelId <= index) {
                  q.add(quizes[i]);
                }
                if (q.length == 10) break;
              }
            }
            levels.add(Level(title, id, false, 0, q));
            index2++;
            index += 3;
          } while (index <= levels.length);
        }
      }
      isLoading.value = false;
    } on SocketException catch (_) {
      isLoading.value = false;
      Get.rawSnackbar(title: "connection", message: "unable to connect");
    }
  }

  RxList<Subject> allSubjects = new List<Subject>().obs;
  void getSubjects() async {
    try {
      isLoading.value = true;

      allSubjects.clear();
      http.Response temp = await http
          .get(Uri.parse(url + getAllSubjectionsUrl), headers: headers)
          .timeout(Duration(seconds: 30));
      final data = jsonDecode(temp.body);

      if (data.containsKey("data")) {
        for (int i = 0; i < data["data"].length; i++) {
          allSubjects.add(Subject.fromJson(data["data"][i]));
        }
      }
      isLoading.value = false;
    } on SocketException catch (_) {
      isLoading.value = false;
      Get.rawSnackbar(title: "connection", message: "unable to connect");
    }
  }
}
