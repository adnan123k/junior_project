import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:flutter/material.dart';
import 'package:junior_project/data.dart';
import 'package:junior_project/model/question/question.dart';
import 'package:junior_project/view/pages/questionForm.dart';
import 'package:junior_project/view/widget/appBar.dart';
import 'package:junior_project/view/widget/backButton.dart';
import 'package:junior_project/view/widget/container.dart';
import 'package:junior_project/view/widget/drawer.dart';

import 'package:junior_project/view/widget/dropdownButton.dart';
import 'package:junior_project/view/widget/listView.dart';
import 'package:junior_project/view/widget/raisedButton.dart';
import 'package:junior_project/view/widget/textForm.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class lessonForm extends StatefulWidget {
  final isEditable;
  final isHomeWork;
  lessonForm({this.isEditable = true, this.isHomeWork = false});

  @override
  State<lessonForm> createState() => _lessonForm();
}

class _lessonForm extends State<lessonForm> {
  final ImagePicker _picker = ImagePicker();
  XFile video = null;
  VideoPlayerController _controller;
  var drawerKey = GlobalKey<SwipeDrawerState>();
  List<Question> _questions = new List<Question>();
  String initValue = "رياضيات";
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_controller != null) _controller.dispose();
  }

  void videoPicker(height) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheet(onClosing: () {
          print("closed");
        }, builder: (context) {
          return container(
              height: height * 0.1,
              child: normalButton(
                  radius: 0.0,
                  function: () async {
                    video =
                        await _picker.pickVideo(source: ImageSource.gallery);
                    if (video != null) {
                      _controller =
                          VideoPlayerController.file(File(video.path));
                      await _controller.initialize();
                      setState(() {});
                    }
                  },
                  child: Text(
                    "انتقاء الفيديو",
                    textDirection: textDirection,
                  )));
        });
      },
    );
  }

  Widget subjectPicker(height, width, widthContainer) {
    return container(
        height: height > 500 ? 50 : height * 0.5,
        width: widthContainer,
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          container(
              height: height > 500 ? 50 : height * 0.1,
              width: width * 0.2,
              child: dropDownButton(
                  function: (value) {
                    setState(() {
                      initValue = value;
                    });
                  },
                  initValue: initValue,
                  list: [
                    DropdownMenuItem(
                        value: subjectName[0],
                        child: Text(
                          subjectName[0],
                        )),
                    DropdownMenuItem(
                        value: subjectName[1], child: Text(subjectName[1])),
                    DropdownMenuItem(
                        value: subjectName[2], child: Text(subjectName[2]))
                  ])),
          AutoSizeText(
            "اختار المادة:",
            textDirection: textDirection,
            style: TextStyle(fontSize: 20, color: Colors.blue),
          )
        ]));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double widthContainer = width * 0.8;

    return customizeDrawer(
        GestureDetector(
            onTap: () {
              return FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
              bottomSheet: container(
                  width: width,
                  height: height * 0.1,
                  color: Colors.blue[400],
                  child: FlatButton(
                      child: AutoSizeText("تاكيد",
                          textDirection: textDirection,
                          style: TextStyle(fontSize: 30.0)))),
              appBar: appBar(
                  leading: widget.isHomeWork
                      ? backButton(context)
                      : widget.isEditable
                          ? backButton(context)
                          : InkWell(
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
                              ))),
              body: container(
                  height: height,
                  width: width,
                  bottom: height * 0.1,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        widget.isHomeWork
                            ? SizedBox()
                            : GestureDetector(
                                onTap: () {
                                  videoPicker(height);
                                },
                                child: container(
                                  height: height > 500
                                      ? height * 0.3
                                      : height * 0.5,
                                  width: widthContainer,
                                  borderColor: Color(0xffFF00E4),
                                  borderStyle: video == null
                                      ? BorderStyle.solid
                                      : BorderStyle.none,
                                  child: video == null
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.add),
                                            Text("اضافة فيديو")
                                          ],
                                        )
                                      : VideoPlayer(_controller),
                                )),
                        SizedBox(
                          height: widget.isHomeWork ? 0.0 : 10.0,
                        ),
                        container(
                            height: height > 500 ? 50 : height * 0.2,
                            width: width > 500 ? 400 : widthContainer,
                            child: textForm(
                                hintText: "العنوان",
                                hintDirection: textDirection,
                                textDirection: textDirection,
                                radius: 10.0)),
                        SizedBox(
                          height: 10.0,
                        ),
                        widget.isHomeWork
                            ? SizedBox()
                            : container(
                                height: height > 500 ? 150 : height * 0.8,
                                width: widthContainer,
                                child: textForm(
                                    hintText: "الوصف",
                                    hintDirection: textDirection,
                                    type: TextInputType.multiline,
                                    maxLines: 1000,
                                    isContentPadding: true,
                                    cph: padding,
                                    cpv: padding,
                                    textDirection: textDirection)),
                        SizedBox(
                          height: widget.isHomeWork ? 0.0 : 10.0,
                        ),
                        subjectPicker(height, width, widthContainer),
                        SizedBox(
                          height: 10.0,
                        ),
                        container(
                            width: widthContainer,
                            child: FlatButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return QuestionForm(widget.isHomeWork);
                                  })).then((value) {
                                    if (value != null) {
                                      _questions.add(value);
                                      setState(() {});
                                    }
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: Colors.blue,
                                    ),
                                    Text(
                                      "اضافة سؤال",
                                      textDirection: textDirection,
                                      style: TextStyle(color: Colors.blue),
                                    )
                                  ],
                                ))),
                        SizedBox(
                          height: 10.0,
                        ),
                        container(
                            height: height * 0.3,
                            width: widthContainer,
                            child: listView(
                                itemCount: _questions.length,
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    thickness: 2.0,
                                  );
                                },
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    leading: container(
                                        width: width * 0.3,
                                        height: 10.0,
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(Icons.delete,
                                                    color: Colors.red)),
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(Icons.edit),
                                                color: Colors.blue)
                                          ],
                                        )),
                                    trailing: AutoSizeText(
                                      _questions[index].question,
                                      textDirection: textDirection,
                                      softWrap: true,
                                    ),
                                  );
                                })),
                      ],
                    ),
                  )),
            )),
        drawerKey,
        "video");
  }
}
