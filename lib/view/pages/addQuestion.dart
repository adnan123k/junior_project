import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junior_project/controller/levelController.dart';
import 'package:junior_project/model/question.dart';
import 'package:junior_project/view/pages/questionForm.dart';
import 'package:junior_project/view/widget/alertDialog.dart';
import 'package:junior_project/view/widget/appBar.dart';
import 'package:junior_project/view/widget/backButton.dart';

import 'package:junior_project/view/widget/dropdownButton.dart';
import 'package:junior_project/view/widget/listView.dart';

import '../../data.dart';
import 'package:junior_project/view/widget/container.dart';

class AddQuestionPage extends StatefulWidget {
  final subject;
  AddQuestionPage(this.subject);

  @override
  State<AddQuestionPage> createState() => _AddQuestionPage();
}

class _AddQuestionPage extends State<AddQuestionPage> {
  List<DropdownMenuItem<dynamic>> temp = new List<DropdownMenuItem<dynamic>>();

  List<Question> questions = new List<Question>();
  int initValue = 0;
  final LevelController _levelController = Get.find<LevelController>();
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    temp.clear();
    if (widget.subject.lessons.length > 0) {
      initValue = widget.subject.lessons[0].id;
      for (int i = 0; i < widget.subject.lessons.length; i++) {
        temp.add(DropdownMenuItem(
            value: widget.subject.lessons[i].id,
            child: Text(widget.subject.lessons[i].title)));
      }
    }
  }

  void submit() {
    if (questions.length >= 10) {
      _levelController.postQuestions(
          questions: questions, subjectId: widget.subject.id, id: initValue);

      return Get.back();
    }
    showAlertDialog(context,
        content: Text("يجب على الاقل ان يكونو ١٠ اسئلة"),
        action: [
          FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "حسنا",
                style: TextStyle(color: Colors.blue),
              ))
        ]);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        bottomSheet: container(
            width: width,
            height: height * 0.1,
            color: Colors.amber[400],
            child: FlatButton(
                child: AutoSizeText("تاكيد",
                    textDirection: textDirection,
                    style: TextStyle(fontSize: 30.0)),
                onPressed: submit)),
        appBar: appBar(leading: backButton()),
        body: widget.subject.lessons.length == 0
            ? Center(child: Text("لا يوجد دروس"))
            : SingleChildScrollView(
                padding: EdgeInsets.all(padding),
                child: Column(
                  children: [
                    dropDownButton(
                        initValue: initValue,
                        list: temp,
                        function: (value) {
                          setState(() {
                            initValue = value;
                          });
                        }),
                    SizedBox(
                      height: padding,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                            onPressed: () {
                              Get.to(QuestionForm()).then((value) {
                                if (value != null) {
                                  setState(() {
                                    questions.add(value);
                                  });
                                }
                              });
                            },
                            child: Text(
                              "اضافة سؤال",
                            ))),
                    Divider(),
                    container(
                        height: height * 0.7,
                        width: width,
                        bottom: height * 0.1,
                        color: Colors.transparent,
                        child: listView(
                            itemCount: questions.length,
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                            itemBuilder: (context, index) {
                              return ListTile(
                                trailing: Text(questions[index].question),
                              );
                            }))
                  ],
                )));
  }
}
