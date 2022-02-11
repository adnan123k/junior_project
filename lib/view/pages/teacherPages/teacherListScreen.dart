import 'dart:async';

import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junior_project/controller/userController.dart';
import 'package:junior_project/model/user.dart';

import 'package:junior_project/view/pages/teacherPages/teacherForm.dart';

import 'package:junior_project/view/widget/appBar.dart';
import 'package:junior_project/view/widget/container.dart';
import 'package:junior_project/view/widget/drawer.dart';
import 'package:junior_project/view/widget/listView.dart';

import 'package:junior_project/view/widget/searchBar.dart';

import 'TeacherPage.dart';

class TeacherListPage extends StatefulWidget {
  TeacherListPage();
  @override
  _TeacherListPage createState() => _TeacherListPage();
}

class _TeacherListPage extends State<TeacherListPage> {
  var drawerKey = GlobalKey<SwipeDrawerState>();
  TextEditingController searchController = new TextEditingController();
  List<User> searchedTeacher = [];
  final UserController _userController = Get.find<UserController>();
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Timer(Duration.zero, () {
      _userController.getTeacher();
    });
  }

  void searchForATeacher(String value) {
    setState(() {
      List<User> temp = [];
      _userController.teachers.forEach((element) {
        if (element.userName.contains(value.trim())) {
          temp.add(element);
        }
      });
      searchedTeacher = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return TeacherForm();
                        }));
                      },
                      icon: Icon(Icons.add),
                      color: Colors.green)
                ],
                title: searchBar(
                    width, height, searchController, searchForATeacher)),
            body: _userController.isLoading.isTrue
                ? Center(child: CircularProgressIndicator())
                : listView(
                    itemCount: searchedTeacher.length != 0
                        ? searchedTeacher.length
                        : _userController.teachers.length,
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colors.black,
                      );
                    },
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return TeacherPage(searchedTeacher.length != 0
                                ? searchedTeacher[index]
                                : _userController.teachers[index]);
                          }));
                        },
                        leading: Text(searchedTeacher.length != 0
                            ? searchedTeacher[index].userName
                            : _userController.teachers[index].userName),
                        trailing: container(
                            width: width * 0.3,
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      return Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return TeacherForm(
                                            teacher: searchedTeacher.length != 0
                                                ? searchedTeacher[index]
                                                : _userController
                                                    .teachers[index]);
                                      }));
                                    },
                                    icon: Icon(Icons.edit, color: Colors.grey)),
                                IconButton(
                                    onPressed: () {
                                      _userController.deleteTeacher(
                                          id: searchedTeacher.length != 0
                                              ? searchedTeacher[index].id
                                              : _userController
                                                  .teachers[index].id);
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ))
                              ],
                            )),
                      );
                    }),
          ),
          drawerKey,
          "teachers");
    });
  }
}
