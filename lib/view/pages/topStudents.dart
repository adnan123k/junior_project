import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junior_project/controller/authController.dart';
import 'package:junior_project/controller/userController.dart';
import 'package:junior_project/data.dart';
import 'package:junior_project/view/widget/appBar.dart';

import 'package:junior_project/view/widget/drawer.dart';
import 'package:junior_project/view/widget/listView.dart';

class TopStudents extends StatefulWidget {
  TopStudents();
  @override
  _TopStudents createState() => _TopStudents();
}

class _TopStudents extends State<TopStudents> {
  var drawerKey = GlobalKey<SwipeDrawerState>();
  final UserController _userController = Get.find<UserController>();
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Timer(Duration.zero, () {
      _userController.getTop10Student();
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Obx(() {
      return customizeDrawer(
          Scaffold(
            appBar: appBar(
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
                    color: Colors.black,
                    size: height > 500 ? 30 : height * 0.1,
                  )),
            ),
            body: _userController.isLoading.isTrue
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : listView(
                    itemCount: _userController.topStudent.length,
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colors.black,
                      );
                    },
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: AutoSizeText(
                          _userController.topStudent[index].userName,
                          textDirection: textDirection,
                          style: TextStyle(fontSize: height * 0.2),
                        ),
                        trailing: AutoSizeText(
                          "النقاط:" +
                              _userController.topStudent[index].points
                                  .toString(),
                          textDirection: textDirection,
                          style: TextStyle(fontSize: height * 0.2),
                        ),
                      );
                    }),
          ),
          drawerKey,
          "best students");
    });
  }
}
