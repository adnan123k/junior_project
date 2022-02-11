import 'dart:async';

import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:junior_project/controller/levelController.dart';
import 'package:junior_project/controller/userController.dart';

import 'package:junior_project/view/widget/appBar.dart';

import '../../data.dart';
import '../widget/drawer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../widget/container.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'playMode.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  var drawerKey = GlobalKey<SwipeDrawerState>();
  List<Widget> _widgets = new List<Widget>();
  double opacity = 0.7;
  double radius = 10.0;
  double width = 0.0;
  double height = 0.0;
  final UserController controller = Get.find<UserController>();
  final LevelController _levelController = Get.put(LevelController());
  double containerWidth = 0.0;
  double containerHeight = 0.0;

  double fontSize = 0.0;
  double containerPadding = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    containerWidth = width > 500 ? width * 0.2 : width * 0.4;
    containerHeight = height > 500 ? height * 0.4 : height * 0.2;
    fontSize = width * 0.1;
    containerPadding = width > 500 ? padding * 4 : padding * 2;
    Timer(Duration.zero, () {
      _levelController.getSubjects();
    });
  }

  Widget challengeMaker(challenge) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(
                  MaterialPageRoute(builder: (context) => PlayMode(challenge)))
              .then((_) {
            setState(() {});
          });
        },
        child: container(
            width: width * 0.8,
            height: height * 0.1,
            opacity: 0.8,
            padding: padding,
            radius: radius,
            child: AutoSizeText(challenge.title,
                style: TextStyle(fontSize: 32, color: Color(0xff911F27)),
                textDirection: textDirection),
            image: AssetImage(challenge.title == "تحليل"
                ? calculasImage
                : challenge.title == "جبر"
                    ? algabraImage
                    : engineerImage)));
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      _widgets.clear();
      for (int i = 0; i < _levelController.allSubjects.length; i++) {
        _widgets.add(challengeMaker(_levelController.allSubjects[i]));
      }

      return customizeDrawer(
          Scaffold(
            appBar: appBar(
              color: Color(0xff04293A),
              leading: InkWell(
                  onTap: () {
                    if (drawerKey.currentState.isOpened()) {
                      drawerKey.currentState.closeDrawer();
                    } else {
                      drawerKey.currentState.openDrawer();
                    }
                  },
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: height > 500 ? 30 : height * 0.1,
                  )),
            ),
            body: container(
                width: width,
                height: height,
                padding: padding,
                color: Color(0xff04293A),
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                      AutoSizeText(controller.currentUser.value.userName,
                          style: TextStyle(fontSize: 32, color: Colors.white)),
                      SizedBox(height: padding),
                      Divider(
                        thickness: 2.0,
                        color: Colors.white,
                      ),
                      SizedBox(height: padding),
                      AutoSizeText(
                          controller.currentUser.value.points.toString() +
                              " :عدد النقاط",
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                          )),
                      SizedBox(height: padding),
                      Divider(
                        thickness: 2.0,
                        color: Colors.white,
                      ),
                      SizedBox(height: padding),
                      AutoSizeText(
                          "اسم الام" +
                              " : " +
                              controller.currentUser.value.motherName,
                          textDirection: textDirection,
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                          )),
                      SizedBox(height: padding),
                      Divider(
                        thickness: 2.0,
                        color: Colors.white,
                      ),
                      SizedBox(height: padding),
                      AutoSizeText(
                          "اسم الاب" +
                              " : " +
                              controller.currentUser.value.fatherName,
                          textDirection: textDirection,
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                          )),
                      SizedBox(height: padding),
                      Divider(
                        thickness: 2.0,
                        color: Colors.white,
                      ),
                      SizedBox(height: padding),
                      AutoSizeText(":تحديات",
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                          )),
                      SizedBox(height: padding),
                      Obx(() => _levelController.isLoading.isTrue
                          ? Center(child: CircularProgressIndicator())
                          : CarouselSlider(
                              options: CarouselOptions(
                                autoPlay: true,
                                height: height * 0.3,
                                enlargeCenterPage: true,
                              ),
                              items: _widgets))
                    ]))),
          ),
          drawerKey,
          "home");
    });
  }
}
