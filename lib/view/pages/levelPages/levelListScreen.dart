import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:junior_project/controller/levelController.dart';

import 'package:junior_project/controller/userController.dart';

import 'package:junior_project/model/question.dart';

import 'package:junior_project/view/pages/addQuestion.dart';

import 'package:junior_project/view/widget/appBar.dart';
import 'package:junior_project/view/widget/container.dart';

import 'package:junior_project/view/widget/listView.dart';
import 'package:timer_count_down/timer_controller.dart';
import '../../widget/backButton.dart';
import 'levelScreen.dart';

class LevelListPage extends StatefulWidget {
  final subject;

  LevelListPage(this.subject);

  @override
  _LevelListPage createState() => _LevelListPage();
}

class _LevelListPage extends State<LevelListPage> {
  final LevelController _levelController = Get.find<LevelController>();
  final UserController c = Get.find<UserController>();
  void didChangeDependencies() {
    super.didChangeDependencies();
    Timer(Duration.zero, () {
      _levelController.getLevels(widget.subject.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Obx(() {
      List<bool> t = new List<bool>();
      _levelController.levels.forEach((element) {
        t.add(element.passed);
      });

      return Scaffold(
        appBar: appBar(leading: backButton(), actions: [
          c.currentUser.value.type != "teacher"
              ? SizedBox()
              : IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return AddQuestionPage(widget.subject);
                    }));
                  },
                  icon: Icon(Icons.add, color: Colors.green))
        ]),
        body: _levelController.isLoading.isTrue
            ? Center(child: CircularProgressIndicator())
            : _levelController.levels.length == 0
                ? Center(
                    child: Text("no levels is found"),
                  )
                : listView(
                    separatorBuilder: (context, index) {
                      return Divider(color: Colors.black);
                    },
                    itemCount: _levelController.levels.length,
                    itemBuilder: (context, index) {
                      Widget temp = ListTile(
                        onTap: () {
                          if (!(index != 0 && !t[index - 1])) {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return LevelPage(
                                  0,
                                  false,
                                  [],
                                  false,
                                  0,
                                  List<Question>.from(
                                      _levelController.levels[index].questions),
                                  _levelController.levels[index].subjectId,
                                  10 * 60);
                            }));
                          }
                        },
                        leading: container(
                            width: width * 0.3,
                            color: Colors.transparent,
                            child: Text(
                              _levelController.levels[index].title,
                            )),
                        trailing: (index != 0 && !t[index - 1])
                            ? Icon(Icons.lock)
                            : t[index]
                                ? Icon(
                                    Icons.done,
                                    color: Colors.green,
                                  )
                                : Icon(Icons.arrow_forward_ios),
                      );

                      return temp;
                    }),
      );
    });
  }
}
