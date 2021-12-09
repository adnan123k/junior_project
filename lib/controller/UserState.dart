import 'dart:convert';

import 'package:junior_project/data.dart';

import '../model/comment.dart';
import '../model/discussion.dart';
import '../model/user.dart';
import 'Auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserState extends ChangeNotifier {
  static bool isLoading = false;
  List<User> topStudent = new List<User>();
  List<Discussion> userDiscussions = new List<Discussion>();
  List<Discussion> allDiscussions = new List<Discussion>();
  List<Comment> allComments = new List<Comment>();
  void updatePoint(int point) async {
    isLoading = true;
    notifyListeners();
    http.Response temp = await http.put(Uri.parse(url + updatePointurl),
        headers: headers, body: jsonEncode({"point": point}));
    final data = jsonDecode(temp.body);
    if (data.containsKey("message") && data["message"] == "success") {
      AuthController.currentUser.points += point;
      final tmp = await AuthController.localData;
      tmp.setInt("point", AuthController.currentUser.points);
    }
    isLoading = false;
    notifyListeners();
  }

  void getTop10Student() async {
    isLoading = true;

    notifyListeners();
    topStudent.clear();
    http.Response temp =
        await http.get(Uri.parse(url + top10StudentUrl), headers: headers);
    final data = jsonDecode(temp.body);
    if (data.containsKey("data")) {
      for (int i = 0; i < data["data"].length; i++) {
        topStudent.add(User.fromJson2(data["data"][i]));
      }
    }
    isLoading = false;
    notifyListeners();
  }

  void getUserDiscussion() async {
    isLoading = true;

    notifyListeners();
    userDiscussions.clear();
    http.Response temp =
        await http.get(Uri.parse(url + getUserDisscusionUrl), headers: headers);
    final data = jsonDecode(temp.body);
    if (data.containsKey("data")) {
      for (int i = 0; i < data["data"].length; i++) {
        userDiscussions.add(Discussion.fromJson(data["data"][i]));
      }
    }
    isLoading = false;
    notifyListeners();
  }

  void getAllDiscussion(int id) async {
    isLoading = true;

    notifyListeners();
    allDiscussions.clear();
    http.Response temp = await http.get(
        Uri.parse(url + id.toString() + getAllDisscusionUrl),
        headers: headers);
    final data = jsonDecode(temp.body);
    if (data.containsKey("data")) {
      for (int i = 0; i < data["data"].length; i++) {
        allDiscussions.add(Discussion.fromJson(data["data"][i]));
      }
    }
    isLoading = false;
    notifyListeners();
  }

  void getAllComments(int id) async {
    isLoading = true;

    notifyListeners();
    allComments.clear();
    http.Response temp = await http.get(
        Uri.parse(url + id.toString() + getAllCommentsUrl),
        headers: headers);
    final data = jsonDecode(temp.body);
    if (data.containsKey("data")) {
      for (int i = 0; i < data["data"].length; i++) {
        allComments.add(Comment.fromJson(data["data"][i]));
      }
    }
    isLoading = false;
    notifyListeners();
  }

  void putLikeOnDiscussion(int id, String operation) async {
    isLoading = true;

    notifyListeners();

    await http.put(Uri.parse(url + id.toString() + putLikeOnDiscussionUrl),
        headers: headers, body: jsonEncode({"operation": operation}));

    isLoading = false;
    notifyListeners();
  }

  void putLikeOnComment(int id, String operation) async {
    isLoading = true;

    notifyListeners();

    await http.put(Uri.parse(url + id.toString() + putLikeOnCommentUrl),
        headers: headers, body: jsonEncode({"operation": operation}));

    isLoading = false;
    notifyListeners();
  }

  void deleteDiscussion(int id) async {
    isLoading = true;

    notifyListeners();

    await http.delete(Uri.parse(url + id.toString() + deleteDisscusionUrl),
        headers: headers);
    Discussion temp;
    userDiscussions.forEach((element) {
      if (element.id == id) temp = element;
    });

    if (temp != null) userDiscussions.remove(temp);
    allDiscussions.forEach((element) {
      if (element.id == id) temp = element;
    });
    if (allDiscussions.length > 0) allDiscussions.remove(temp);
    isLoading = false;
    notifyListeners();
  }

  void deleteComment(int id) async {
    isLoading = true;

    notifyListeners();

    await http.delete(Uri.parse(url + id.toString() + deleteCommentUrl),
        headers: headers);
    Comment temp;

    allComments.forEach((element) {
      if (element.id == id) temp = element;
    });
    if (allComments.length > 0) allComments.remove(temp);
    isLoading = false;
    notifyListeners();
  }

  void postComment(int id, String body) async {
    isLoading = true;

    notifyListeners();
    http.Response temp = await http.post(
        Uri.parse(url + id.toString() + postCommentUrl),
        headers: headers,
        body: jsonEncode({"body": body}));
    final data = jsonDecode(temp.body);
    if (data.containsKey("data"))
      allComments.add(Comment.fromJson(data["data"]));
    isLoading = false;
    notifyListeners();
  }

  void postDiscussion(int id, String body) async {
    isLoading = true;

    notifyListeners();
    http.Response temp = await http.post(
        Uri.parse(url + id.toString() + postCommentUrl),
        headers: headers,
        body: jsonEncode({"body": body}));
    final data = jsonDecode(temp.body);
    if (data.containsKey("data"))
      allDiscussions.add(Discussion.fromJson(data["data"]));
    isLoading = false;
    notifyListeners();
  }
}
