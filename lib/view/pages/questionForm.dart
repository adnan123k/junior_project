import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:junior_project/model/question/checkBoxQuestion.dart';
import 'package:junior_project/model/question/inputQuestion.dart';
import 'package:junior_project/model/question/question.dart';
import 'package:junior_project/model/question/radioQuestion.dart';
import 'package:junior_project/view/widget/appBar.dart';
import 'package:junior_project/view/widget/backButton.dart';
import 'package:junior_project/view/widget/dropdownButton.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:junior_project/view/widget/textForm.dart';
import '../../data.dart';
import 'package:junior_project/view/widget/container.dart';

class QuestionForm extends StatefulWidget {
  final isHomeWork;
  QuestionForm(this.isHomeWork);

  @override
  State<QuestionForm> createState() => _QuestionForm();
}

class _QuestionForm extends State<QuestionForm> {
  String initQuestionvalue = questionsType[2];

  Question question;
  List<String> checkBoxChoices = [];
  List<String> radioChoices = [];
  String answer;
  List<String> checkBoxAnswers = [];

  TextEditingController questionController = new TextEditingController();
  TextEditingController answerController = new TextEditingController();
  TextEditingController time = new TextEditingController();

  void submit() {
    int hours = int.parse(time.text[0] + time.text[1]);
    int minutes = int.parse(time.text[3] + time.text[4]);
    int seconds = int.parse(time.text[6] + time.text[7]);
    if (initQuestionvalue == questionsType[1]) {
      question = checkBoxQuestion(
          choices: checkBoxChoices,
          answer: checkBoxAnswers,
          question: questionController.text,
          type: questionsType[1],
          seconds: widget.isHomeWork
              ? 0.0
              : Duration(hours: hours, minutes: minutes, seconds: seconds)
                  .inSeconds);
    } else if (initQuestionvalue == questionsType[0]) {
      question = radioQuestion(
          choices: checkBoxChoices,
          answer: answer,
          question: questionController.text,
          type: questionsType[0],
          seconds: widget.isHomeWork
              ? 0.0
              : Duration(hours: hours, minutes: minutes, seconds: seconds)
                  .inSeconds);
    } else {
      question = inputQuestion(
          answer: answer,
          question: questionController.text,
          type: questionsType[2],
          seconds: widget.isHomeWork
              ? 0.0
              : Duration(hours: hours, minutes: minutes, seconds: seconds)
                  .inSeconds);
    }

    Navigator.of(context).pop(question);
  }

  Widget type(height, width) {
    double containerHeight = height * 0.1;
    double containerWidth = width * 0.3;
    return container(
        width: width,
        height: containerHeight,
        child: Row(
          textDirection: textDirection,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            container(
                height: containerHeight,
                width: containerWidth,
                child: AutoSizeText(
                  "اختار نوع السؤال: ",
                  textDirection: textDirection,
                )),
            container(
                height: containerHeight,
                width: containerWidth,
                child: dropDownButton(
                    initValue: initQuestionvalue,
                    list: [
                      DropdownMenuItem(
                          value: questionsType[0],
                          child: AutoSizeText(questionsType[0],
                              textDirection: textDirection)),
                      DropdownMenuItem(
                          value: questionsType[1],
                          child: AutoSizeText(questionsType[1],
                              textDirection: textDirection)),
                      DropdownMenuItem(
                          value: questionsType[2],
                          child: AutoSizeText(questionsType[2],
                              textDirection: textDirection))
                    ],
                    function: (value) {
                      setState(() {
                        initQuestionvalue = value;
                      });
                    })),
          ],
        ));
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
        appBar: appBar(leading: backButton(context)),
        body: container(
            height: height,
            width: width,
            bottom: height * 0.1,
            child: SingleChildScrollView(
                padding: EdgeInsets.all(padding),
                child: Column(
                  children: [
                    widget.isHomeWork
                        ? SizedBox()
                        : container(
                            width: width * 0.8,
                            height: height > 500 ? 50 : height * 0.2,
                            child: textForm(
                                radius: 5.0,
                                hintDirection: textDirection,
                                senderController: time,
                                hintText:
                                    "اكتب زمن السؤال في الفيديو بالشكل 00:00:06 بالغة الانكليزية للاعداد"),
                          ),
                    SizedBox(
                      height: widget.isHomeWork ? 0.0 : 10.0,
                    ),
                    type(height, width),
                    container(
                        width: width * 0.8,
                        height: height > 500 ? 50 : height * 0.2,
                        child: textForm(
                            radius: 5.0,
                            textDirection: textDirection,
                            hintDirection: textDirection,
                            senderController: questionController,
                            hintText: "اكتب السؤال")),
                    SizedBox(height: padding),
                    container(
                      width: initQuestionvalue != questionsType[2]
                          ? width
                          : width * 0.8,
                      height: height > 500 ? 50 : height * 0.2,
                      child: initQuestionvalue != questionsType[2]
                          ? Row(
                              children: [
                                FlatButton(
                                    onPressed: () {
                                      if (!answerController.text
                                          .trim()
                                          .isEmpty) {
                                        setState(() {
                                          if (initQuestionvalue ==
                                              questionsType[1]) {
                                            checkBoxChoices
                                                .add(answerController.text);
                                          } else {
                                            radioChoices
                                                .add(answerController.text);
                                          }
                                          answerController.text = "";
                                        });
                                      }
                                    },
                                    child: Row(children: [
                                      Icon(Icons.add, color: Colors.blue),
                                      AutoSizeText("اضافة خيار",
                                          textDirection: textDirection,
                                          style: TextStyle(color: Colors.blue)),
                                      SizedBox(width: padding),
                                      container(
                                          width: width * 0.6,
                                          height:
                                              height > 500 ? 50 : height * 0.1,
                                          child: textForm(
                                              radius: 5.0,
                                              textDirection: textDirection,
                                              hintDirection: textDirection,
                                              senderController:
                                                  answerController,
                                              hintText: "الخيار"))
                                    ]))
                              ],
                            )
                          : textForm(
                              radius: 5.0,
                              textDirection: textDirection,
                              hintDirection: textDirection,
                              senderController: answerController,
                              hintText: "الاجابة الصحيحة"),
                    ),
                    initQuestionvalue != questionsType[1]
                        ? RadioButtonGroup(
                            labels: radioChoices,
                            onSelected: (value) {
                              answer = value;
                            },
                          )
                        : CheckboxGroup(
                            padding: EdgeInsets.all(padding),
                            labels: checkBoxChoices,
                            onSelected: (List<String> checked) =>
                                checkBoxAnswers = checked)
                  ],
                ))));
  }
}
