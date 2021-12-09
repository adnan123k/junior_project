import 'package:flutter/material.dart';
import 'package:junior_project/view/widget/appBar.dart';
import 'package:junior_project/view/widget/backButton.dart';
import 'package:junior_project/view/widget/container.dart';
import 'package:junior_project/view/widget/labelAndText.dart';

class teacherPage extends StatefulWidget {
  final isStudent;
  teacherPage(this.isStudent);

  @override
  _teacherPage createState() => _teacherPage();
}

class _teacherPage extends State<teacherPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double bottomButtonHeight = height > 500 ? 80.0 : height * 0.1;
    Color matchingColor = Colors.amber[400];
    return Scaffold(
        appBar: appBar(leading: backButton(context), color: matchingColor),
        body: container(
            width: width,
            height: height,
            bottom: bottomButtonHeight,
            child: SingleChildScrollView(
                child: Column(children: [
              labelAndTextForm(height, width, "اسم الكامل:", value: "محمد"),
              labelAndTextForm(height, width, "اسم الاب:", value: "محمد"),
              labelAndTextForm(height, width, "اسم الام:", value: "محمد"),
              labelAndTextForm(height, width,
                  widget.isStudent ? "اسم المستخدم" : ":رقم الوطني:",
                  value: "محمد"),
              labelAndTextForm(height, width, "رقم الهاتف:", value: "محمد"),
              labelAndTextForm(height, width, "رقم المحمول:", value: "محمد"),
              labelAndTextForm(height, width, "العنوان:", value: "محمد"),
              labelAndTextForm(height, width, "كلمة المرور:", value: "محمد")
            ]))));
  }
}
