import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:junior_project/data.dart';
import 'package:junior_project/view/widget/appBar.dart';
import 'package:junior_project/view/widget/backButton.dart';
import 'package:junior_project/view/widget/container.dart';
import 'package:junior_project/view/widget/labelAndText.dart';

class teacherForm extends StatefulWidget {
  final isStudent;
  teacherForm(this.isStudent);
  @override
  _teacherForm createState() => _teacherForm();
}

class _teacherForm extends State<teacherForm> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double bottomButtonHeight = height > 500 ? 80.0 : height * 0.1;
    Color matchingColor = Colors.amber[400];
    return Scaffold(
      bottomSheet: container(
          width: width,
          height: bottomButtonHeight,
          color: matchingColor,
          child: FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: AutoSizeText("تاكيد",
                  textDirection: textDirection,
                  style: TextStyle(
                    fontSize: bottomButtonHeight,
                  )))),
      appBar: appBar(leading: backButton(context), color: matchingColor),
      body: container(
        width: width,
        height: height,
        bottom: bottomButtonHeight,
        child: SingleChildScrollView(
            child: Column(
          children: [
            labelAndTextForm(height, width, "اسم الكامل:",
                keyboardType: TextInputType.name),
            labelAndTextForm(height, width, "اسم الاب:",
                keyboardType: TextInputType.name),
            labelAndTextForm(height, width, "اسم الام:",
                keyboardType: TextInputType.name),
            labelAndTextForm(height, width,
                widget.isStudent ? "اسم المستخدم " : ":رقم الوطني: ",
                keyboardType:
                    widget.isStudent ? TextInputType.text : TextInputType.phone,
                textDirection: TextDirection.ltr),
            labelAndTextForm(height, width, "رقم الهاتف:",
                keyboardType: TextInputType.phone,
                textDirection: TextDirection.ltr),
            labelAndTextForm(height, width, "رقم المحمول:",
                keyboardType: TextInputType.phone,
                textDirection: TextDirection.ltr),
            labelAndTextForm(height, width, "العنوان:"),
            labelAndTextForm(height, width, "كلمة المرور:",
                textDirection: TextDirection.ltr),
            widget.isStudent ? SizedBox() : CheckboxGroup(labels: subjectName)
          ],
        )),
      ),
    );
  }
}
