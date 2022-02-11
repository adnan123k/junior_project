import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:junior_project/controller/levelController.dart';
import 'package:junior_project/controller/userController.dart';
import 'package:junior_project/view/widget/appBar.dart';
import 'package:junior_project/view/widget/backButton.dart';
import 'package:junior_project/view/widget/container.dart';

import 'package:timer_count_down/timer_count_down.dart';
import '../../../data.dart';

class LevelPage extends StatefulWidget {
  final int i;
  final isFinalResult;
  final List<bool> result;
  final showResult;
  int rightAnswerCount;
  final questions;

  final subjectId;
  final time;
  LevelPage(this.i, this.isFinalResult, this.result, this.showResult,
      this.rightAnswerCount, this.questions, this.subjectId, this.time);

  @override
  _LevelPage createState() => _LevelPage();
}

class _LevelPage extends State<LevelPage> {
  final UserController c = Get.find<UserController>();
  final LevelController _levelController = Get.find<LevelController>();

  String txt() {
    if (widget.i == (widget.questions.length - 1)) {
      return "النهاية";
    } else {
      return "التالي";
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  String answer = "";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Countdown(
        seconds: widget.time.toInt(),
        onFinished: () {
          if (!(widget.isFinalResult || widget.showResult))
            Navigator.pop(context);
        },
        build: (context, time) {
          return Scaffold(
            bottomSheet: widget.i == widget.questions.length
                ? SizedBox()
                : container(
                    width: width,
                    height: height > 500 ? 80 : height * 0.2,
                    color: Colors.blue[400],
                    child: FlatButton(
                        onPressed: () {
                          if (!widget.showResult &&
                              widget.i != widget.questions.length) {
                            widget.result.add(
                                widget.questions[widget.i].answer == answer);
                          }

                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            if (widget.questions[widget.i].answer == answer &&
                                !widget.showResult &&
                                widget.i != widget.questions.length) {
                              widget.questions[widget.i].passed = true;
                            }
                            return LevelPage(
                                widget.i + 1,
                                widget.i + 1 == widget.questions.length,
                                widget.result,
                                widget.showResult,
                                (!widget.showResult &&
                                        widget.i != widget.questions.length)
                                    ? widget.questions[widget.i].answer ==
                                            answer
                                        ? widget.rightAnswerCount + 1
                                        : widget.rightAnswerCount
                                    : widget.rightAnswerCount,
                                widget.questions,
                                widget.subjectId,
                                (!(widget.isFinalResult || widget.showResult))
                                    ? time
                                    : widget.time);
                          }));
                        },
                        child: AutoSizeText(
                          txt(),
                          textDirection: textDirection,
                          style: TextStyle(fontSize: 30.0),
                        ))),
            appBar: appBar(leading: backButton(), actions: [
              Padding(
                  padding: EdgeInsets.all(padding),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: AutoSizeText(
                      !(widget.isFinalResult || widget.showResult)
                          ? ((time).toInt() / 60.toInt()).toInt().toString() +
                              ":" +
                              (time % 60).toInt().toString()
                          : ((widget.time).toInt() / 60.toInt())
                                  .toInt()
                                  .toString() +
                              ":" +
                              (widget.time % 60).toInt().toString(),
                      style: TextStyle(fontSize: 20, color: Colors.blueAccent),
                    ),
                  ))
            ]),
            body: widget.isFinalResult
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                          widget.rightAnswerCount / widget.result.length >= 0.5
                              ? passedImage
                              : failedImage),
                      AutoSizeText(
                          widget.rightAnswerCount.toString() +
                              "/" +
                              widget.result.length.toString(),
                          style: TextStyle(
                              color: widget.rightAnswerCount /
                                          widget.result.length >=
                                      0.5
                                  ? Colors.green
                                  : Colors.red)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlatButton(
                              onPressed: () {
                                if (c.currentUser.value.type == "student") {
                                  int p = 0;
                                  widget.questions.forEach((element) {
                                    if (element.passed) {
                                      p += element.point;
                                    }
                                  });
                                  c.updatePoint(p);
                                  c.postUserAttemp(questions: widget.questions);
                                  if (widget.rightAnswerCount /
                                          widget.result.length >=
                                      0.5) {
                                    _levelController.postUserLevel(
                                        id: widget.questions[0].levelId,
                                        subjectId: widget.subjectId);
                                  }
                                }
                                return Navigator.of(context).pop();
                              },
                              child: AutoSizeText(
                                "النهاية",
                                style: TextStyle(color: Colors.blueAccent),
                              )),
                          FlatButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                                  return LevelPage(
                                      0,
                                      false,
                                      widget.result,
                                      true,
                                      widget.rightAnswerCount,
                                      widget.questions,
                                      widget.subjectId,
                                      (!(widget.isFinalResult ||
                                              widget.showResult))
                                          ? time
                                          : widget.time);
                                }));
                              },
                              child: AutoSizeText(
                                "النتائج",
                                style: TextStyle(color: Colors.blueAccent),
                              ))
                        ],
                      )
                    ],
                  )
                : Padding(
                    padding: EdgeInsets.only(
                        top: padding,
                        right: padding,
                        bottom: height > 500 ? 80 : height * 0.2,
                        left: padding),
                    child: SingleChildScrollView(
                      child: container(
                          width: width,
                          color: Colors.transparent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              AutoSizeText(
                                "السؤال",
                                textDirection: textDirection,
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                              AutoSizeText(widget.questions[widget.i].question,
                                  textDirection: textDirection),
                              SizedBox(
                                height: padding,
                              ),
                              AutoSizeText(
                                "الجواب",
                                textDirection: textDirection,
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                              RadioButtonGroup(
                                labels: widget.questions[widget.i].choices,
                                disabled: widget.showResult
                                    ? widget.questions[widget.i].choices
                                    : [],
                                onChange: (value, index) {
                                  setState(() {
                                    answer = value;
                                  });
                                },
                              ),
                              SizedBox(height: padding),
                              widget.showResult
                                  ? container(
                                      width: width,
                                      padding: padding,
                                      color: widget.result[widget.i]
                                          ? Colors.green
                                          : Colors.red,
                                      child: AutoSizeText(
                                          widget.result[widget.i]
                                              ? "you got it right"
                                              : "the answer is " +
                                                  widget.questions[widget.i]
                                                      .answer))
                                  : SizedBox(),
                            ],
                          )),
                    ),
                  ),
          );
        });
  }
}
