import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:junior_project/controller/userController.dart';
import 'package:junior_project/data.dart';
import 'package:junior_project/view/widget/appBar.dart';
import 'package:junior_project/view/widget/backButton.dart';
import 'package:junior_project/view/widget/container.dart';
import 'package:junior_project/view/widget/labelAndText.dart';

import '../../../model/user.dart';
import '../../widget/alertDialog.dart';

class TeacherForm extends StatefulWidget {
  final User teacher;
  TeacherForm({this.teacher});
  @override
  _TeacherForm createState() => _TeacherForm();
}

class _TeacherForm extends State<TeacherForm> {
  TextEditingController userNameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController fullNameController = new TextEditingController();
  TextEditingController fatherController = new TextEditingController();
  TextEditingController motherController = new TextEditingController();
  GlobalKey<FormState> _key = new GlobalKey<FormState>();
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (widget.teacher != null) {
      userNameController.text = widget.teacher.userName;
      fatherController.text = widget.teacher.fatherName;
      motherController.text = widget.teacher.motherName;
    }
  }

  final UserController _userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double bottomButtonHeight = height > 500 ? 80.0 : height * 0.1;
    Color matchingColor = Colors.amber[400];

    return GestureDetector(
        onTap: () {
          return FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          bottomSheet: container(
              width: width,
              height: bottomButtonHeight,
              color: matchingColor,
              child: FlatButton(
                  onPressed: () {
                    if (_key.currentState.validate()) {
                      if (widget.teacher != null) {
                        _userController
                            .putTeacher(
                                username: userNameController.text.trim(),
                                password: passwordController.text.trim(),
                                fullName: fullNameController.text.trim(),
                                motherName: motherController.text.trim(),
                                fatherName: fatherController.text.trim(),
                                id: widget.teacher.id)
                            .then((value) {
                          if (value["error"]) {
                            showAlertDialog(context,
                                content: Text(value["msg"]),
                                action: [
                                  FlatButton(
                                      onPressed: () {
                                        return Get.back();
                                      },
                                      child: Text("ok"))
                                ]);
                          } else {
                            return Get.back();
                          }
                        });
                      } else {
                        _userController
                            .addTeacher(
                                username: userNameController.text.trim(),
                                password: passwordController.text.trim(),
                                fullName: fullNameController.text.trim(),
                                motherName: motherController.text.trim(),
                                fatherName: fatherController.text.trim())
                            .then((value) {
                          if (value["error"]) {
                            showAlertDialog(context,
                                content: Text(value["msg"]),
                                action: [
                                  FlatButton(
                                      onPressed: () {
                                        return Get.back();
                                      },
                                      child: Text("ok"))
                                ]);
                          } else {
                            return Get.back();
                          }
                        });
                      }
                    }
                  },
                  child: AutoSizeText("تاكيد",
                      textDirection: textDirection,
                      style: TextStyle(
                        fontSize: bottomButtonHeight,
                      )))),
          appBar: appBar(leading: backButton(), color: matchingColor),
          body: Form(
            key: _key,
            child: container(
              width: width,
              height: height,
              bottom: bottomButtonHeight,
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  labelAndTextForm(height, width, "اسم الكامل:",
                      textController: fullNameController, validation: (_) {
                    if (fullNameController.text.trim().isEmpty)
                      return "يرجى كتابة الاسم كامل";
                  }, keyboardType: TextInputType.name),
                  labelAndTextForm(height, width, "اسم الاب:",
                      textController: fatherController, validation: (_) {
                    if (fatherController.text.trim().isEmpty)
                      return "يرحى كتابة اسم الاب";
                  }),
                  labelAndTextForm(
                    height,
                    width,
                    "اسم الام:",
                    validation: (_) {
                      if (motherController.text.trim().isEmpty)
                        return "يرجى كتابة اسم الام";
                    },
                    textController: motherController,
                  ),
                  labelAndTextForm(height, width, " اسم المستخدم :",
                      keyboardType: TextInputType.text,
                      textController: userNameController, validation: (_) {
                    if (fullNameController.text.trim().isEmpty)
                      return "username must not be empty";
                  }, textDirection: TextDirection.ltr),
                  labelAndTextForm(height, width, "كلمة المرور:",
                      validation: (_) {
                    if (passwordController.text.trim().isEmpty)
                      return "password mustn\'t be  empty";
                  },
                      textController: passwordController,
                      textDirection: TextDirection.ltr),
                ],
              )),
            ),
          ),
        ));
  }
}
