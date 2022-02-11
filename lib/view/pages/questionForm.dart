import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:junior_project/model/question.dart';
import 'package:junior_project/view/widget/alertDialog.dart';
import 'package:junior_project/view/widget/appBar.dart';
import 'package:junior_project/view/widget/backButton.dart';

import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:junior_project/view/widget/labelAndText.dart';
import 'package:junior_project/view/widget/textForm.dart';
import '../../data.dart';
import 'package:junior_project/view/widget/container.dart';

class QuestionForm extends StatefulWidget {
  @override
  State<QuestionForm> createState() => _QuestionForm();
}

class _QuestionForm extends State<QuestionForm> {
  Question question;
  List<String> checkBoxChoices = [];

  String answer = "";

  TextEditingController questionController = new TextEditingController();
  TextEditingController answerController = new TextEditingController();
  TextEditingController pointController = new TextEditingController();
  void submit() {
    if (_key.currentState.validate()) {
      if (checkBoxChoices.length >= 2 && answer != "") {
        question = Question(
          choices: checkBoxChoices,
          answer: answer,
          point: int.parse(pointController.text.trim()),
          question: questionController.text,
        );

        return Navigator.of(context).pop(question);
      }

      showAlertDialog(context,
          content: Text("يجب على الاقل وضع خيارين"),
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
  }

  GlobalKey<FormState> _key = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
        onTap: () {
          return FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
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
            body: Form(
                key: _key,
                child: container(
                    height: height,
                    width: width,
                    bottom: height * 0.1,
                    child: SingleChildScrollView(
                        padding: EdgeInsets.all(padding),
                        child: Column(
                          children: [
                            container(
                                width: width * 0.8,
                                child: textForm(
                                    radius: 5.0,
                                    textDirection: textDirection,
                                    hintDirection: textDirection,
                                    senderController: questionController,
                                    isContentPadding: true,
                                    cph: padding,
                                    validateFunction: (_) {
                                      if (questionController.text
                                          .trim()
                                          .isEmpty) {
                                        return "يجب وضع سؤال";
                                      }
                                    },
                                    hintText: "اكتب السؤال")),
                            SizedBox(height: padding),
                            labelAndTextForm(height, width, "عدد نقاط السؤال",
                                keyboardType: TextInputType.number,
                                textDirection: TextDirection.ltr,
                                textController: pointController,
                                validation: (_) {
                              if (pointController.text.trim().isEmpty) {
                                return "يجب وضع عدد النقاط";
                              }
                            }),
                            container(
                                width: width,
                                height: height > 500 ? 50 : height * 0.2,
                                child: Row(
                                  children: [
                                    FlatButton(
                                        onPressed: () {
                                          if (!answerController.text
                                              .trim()
                                              .isEmpty) {
                                            setState(() {
                                              checkBoxChoices
                                                  .add(answerController.text);

                                              answerController.text = "";
                                            });
                                          }
                                        },
                                        child: Row(children: [
                                          Icon(Icons.add, color: Colors.blue),
                                          AutoSizeText("اضافة خيار",
                                              textDirection: textDirection,
                                              style: TextStyle(
                                                  color: Colors.blue)),
                                          SizedBox(width: padding),
                                          container(
                                              width: width * 0.6,
                                              height: height > 500
                                                  ? 50
                                                  : height * 0.1,
                                              child: textForm(
                                                  radius: 5.0,
                                                  textDirection: textDirection,
                                                  hintDirection: textDirection,
                                                  senderController:
                                                      answerController,
                                                  hintText: "الخيار"))
                                        ]))
                                  ],
                                )),
                            RadioButtonGroup(
                              labels: checkBoxChoices,
                              onSelected: (value) {
                                answer = value;
                              },
                            )
                          ],
                        ))))));
  }
}
