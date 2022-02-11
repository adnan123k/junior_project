import 'package:flutter/material.dart';

import 'package:junior_project/controller/userController.dart';
import 'package:junior_project/view/pages/discussionScreen.dart';

import 'package:junior_project/view/pages/lessonPages/lessonForm.dart';

import 'package:junior_project/view/pages/teacherPages/teacherListScreen.dart';
import 'package:junior_project/view/pages/topStudents.dart';
import 'view/pages/HomeScreen.dart';
import 'view/pages/loginScreen.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyApp();
  }
}

class _MyApp extends State<StatefulWidget> {
  final UserController c = Get.put(UserController());
  bool isLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    c.isLogin.listen((value) {
      setState(() {
        isLogin = value;
      });
    });
    // if (AuthController.isLogin == null) {
    //   isLogin = false;
    // } else {
    //   AuthController.isLogin.listen((value) {
    //     setState(() {
    //       if (value == null) {
    //         isLogin = false;
    //       } else {
    //         isLogin = value;
    //       }
    //     });
    //   });
    // }

    c.initalize();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) {
          return isLogin ? HomePage() : LoginPage();
        },
        '/home': (context) {
          return isLogin ? HomePage() : LoginPage();
        },
        '/video': (context) {
          return isLogin ? LessonForm(isEditable: false) : LoginPage();
        },
        '/topStudents': (context) {
          return isLogin ? TopStudents() : LoginPage();
        },
        '/discussion': (context) {
          return isLogin
              ? DiscussionPage(
                  myDiscussion: true,
                )
              : LoginPage();
        },
        '/teacher': (context) {
          return isLogin ? TeacherListPage() : LoginPage();
        },
      },
    );
  }
}
