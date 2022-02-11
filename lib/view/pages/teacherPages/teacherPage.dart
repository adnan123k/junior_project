import 'package:flutter/material.dart';
import 'package:junior_project/view/widget/appBar.dart';
import 'package:junior_project/view/widget/backButton.dart';
import 'package:junior_project/view/widget/container.dart';
import 'package:junior_project/view/widget/labelAndText.dart';

import '../../../model/user.dart';

class TeacherPage extends StatefulWidget {
  final User teacher;
  TeacherPage(this.teacher);
  @override
  _TeacherPage createState() => _TeacherPage();
}

class _TeacherPage extends State<TeacherPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double bottomButtonHeight = height > 500 ? 80.0 : height * 0.1;
    Color matchingColor = Colors.amber[400];
    return Scaffold(
        appBar: appBar(leading: backButton(), color: matchingColor),
        body: container(
            width: width,
            height: height,
            bottom: bottomButtonHeight,
            child: SingleChildScrollView(
                child: Column(children: [
              labelAndTextForm(height, width, "اسم الاب:",
                  value: widget.teacher.fatherName),
              labelAndTextForm(height, width, "اسم الام:",
                  value: widget.teacher.motherName),
              labelAndTextForm(height, width, "اسم المستخدم:",
                  value: widget.teacher.userName),
            ]))));
  }
}
