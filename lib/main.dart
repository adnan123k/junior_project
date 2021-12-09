import 'package:flutter/material.dart';
import 'package:junior_project/view/pages/discussionScreen.dart';
import 'package:junior_project/view/pages/homeworkPages/homeWorkListScreen.dart';
import 'package:junior_project/view/pages/lessonPages/lessonForm.dart';
import 'package:junior_project/view/pages/messagesScreen.dart';
import 'package:junior_project/view/pages/teacherPages/teacherListScreen.dart';
import 'package:junior_project/view/pages/topStudents.dart';
import 'view/pages/homeScreen.dart';
import 'view/pages/loginScreen.dart';
import 'view/pages/notificationScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) {
          return loginPage();
        },
        '/home': (context) {
          return homePage();
        },
        '/video': (context) {
          return lessonForm(
            isEditable: false,
          );
        },
        '/topStudents': (context) {
          return topStudents();
        },
        '/messages': (context) {
          return messagesPage();
        },
        '/discussion': (context) {
          return DiscussionPage(
            myDiscussion: true,
          );
        },
        '/notification': (context) {
          return notificationpage();
        },
        '/homework': (context) {
          return homeWorkListPage();
        },
        '/teacher': (context) {
          return teacherListPage();
        },
        '/student': (context) {
          return teacherListPage(isStudent: true);
        }
      },
    );
  }
}
