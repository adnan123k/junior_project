import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junior_project/controller/levelController.dart';
import 'package:junior_project/controller/videoController.dart';
import 'package:junior_project/data.dart';
import 'package:junior_project/model/question.dart';
import 'package:junior_project/view/widget/alertDialog.dart';
import 'package:junior_project/view/widget/appBar.dart';
import 'package:junior_project/view/widget/backButton.dart';
import 'package:junior_project/view/widget/container.dart';
import 'package:junior_project/view/widget/drawer.dart';

import 'package:junior_project/view/widget/dropdownButton.dart';

import 'package:junior_project/view/widget/raisedButton.dart';
import 'package:junior_project/view/widget/textForm.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../../model/video.dart';

class LessonForm extends StatefulWidget {
  final isEditable;

  final Video video;
  LessonForm({this.isEditable = true, this.video});

  @override
  State<LessonForm> createState() => _LessonForm();
}

class _LessonForm extends State<LessonForm> {
  final ImagePicker _picker = ImagePicker();
  File video = null;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  VideoPlayerController _controller;
  var drawerKey = GlobalKey<SwipeDrawerState>();
  List<Question> _questions = new List<Question>();
  int initValue = 0;
  List<DropdownMenuItem> temp = new List<DropdownMenuItem>();

  GlobalKey<FormState> _key = new GlobalKey<FormState>();
  final LevelController _levelController = Get.find<LevelController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isEditable) {
      titleController = TextEditingController(text: widget.video.title);
      descriptionController =
          TextEditingController(text: widget.video.description);
      initValue = widget.video.lessonId;
    }
    temp.clear();
    if (_levelController.allSubjects.length > 0 &&
        _levelController.allSubjects[0].lessons.length > 0) {
      if (!widget.isEditable)
        initValue = _levelController.allSubjects[0].lessons[0].id;
      temp.add(DropdownMenuItem(
          value: initValue,
          child: Text(
            _levelController.allSubjects[0].lessons[0].title,
          )));
      for (int i = 0; i < _levelController.allSubjects.length; i++) {
        for (int j = 0;
            j < _levelController.allSubjects[i].lessons.length;
            j++) {
          bool isFound = false;
          temp.forEach((element) {
            if (element.value == _levelController.allSubjects[i].lessons[j].id)
              isFound = true;
          });
          if (_levelController.allSubjects[i].lessons[j].id != initValue &&
              !isFound)
            temp.add(DropdownMenuItem(
                value: _levelController.allSubjects[i].lessons[j].id,
                child: Text(
                  _levelController.allSubjects[i].lessons[j].title,
                  softWrap: false,
                )));
        }
      }
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

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
        return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return container(
                  height: height * 0.1,
                  child: normalButton(
                      radius: 0.0,
                      function: () async {
                        var temp = await _picker.pickVideo(
                            source: ImageSource.gallery);
                        if (temp != null) video = File(temp.path);

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
        width: width,
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          container(
              height: height > 500 ? 50 : height * 0.1,
              width: width * 0.7,
              child: dropDownButton(
                  function: (value) {
                    setState(() {
                      initValue = value;
                    });
                  },
                  initValue: initValue,
                  list: temp)),
          AutoSizeText(
            "اختار الدرس:",
            textDirection: textDirection,
            style: TextStyle(fontSize: 20, color: Colors.blue),
          )
        ]));
  }

  final VideoController _videoController = Get.put(VideoController());
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
                bottomSheet: initValue == 0
                    ? SizedBox()
                    : _videoController.isLoading.isTrue
                        ? Center(child: CircularProgressIndicator())
                        : container(
                            width: width,
                            height: height > 500 ? height * 0.1 : height * 0.2,
                            color: Colors.blue[400],
                            child: FlatButton(
                                onPressed: () {
                                  if (_key.currentState.validate()) {
                                    if (widget.isEditable) {
                                      _videoController
                                          .putVideo(
                                              video: File(video.path),
                                              title: titleController.text,
                                              description:
                                                  descriptionController.text,
                                              id: initValue,
                                              videoId: widget.video.id)
                                          .then((value) {
                                        if (!value)
                                          showAlertDialog(context,
                                              content: Text(
                                                  ("something went wrong")),
                                              action: [
                                                FlatButton(
                                                    onPressed: () {
                                                      return Get.back();
                                                    },
                                                    child: Text("ok"))
                                              ]);
                                        if (value) {
                                          return Get.back();
                                        }
                                      });
                                    } else {
                                      _videoController
                                          .addVideo(
                                              File(video.path),
                                              titleController.text,
                                              descriptionController.text,
                                              initValue)
                                          .then((value) {
                                        if (value) {
                                          Get.snackbar(
                                              "operation", "video added",
                                              duration: Duration(seconds: 2),
                                              backgroundColor: Colors.white);
                                          Get.offAllNamed("/home");
                                        } else {
                                          return showAlertDialog(context,
                                              content: Text(
                                                  ("something went wrong")),
                                              action: [
                                                FlatButton(
                                                    onPressed: () {
                                                      return Get.back();
                                                    },
                                                    child: Text("ok"))
                                              ]);
                                        }
                                      });
                                    }
                                  }
                                },
                                child: AutoSizeText("تاكيد",
                                    textDirection: textDirection,
                                    style: TextStyle(fontSize: 30.0)))),
                appBar: appBar(
                    leading: widget.isEditable
                        ? backButton()
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
                body: initValue == 0
                    ? Center(
                        child: Text("there no lesson to add video it"),
                      )
                    : Form(
                        key: _key,
                        child: container(
                            height: height,
                            width: width,
                            bottom: height * 0.1,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  GestureDetector(
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
                                    height: padding,
                                  ),
                                  container(
                                      height: height > 500 ? 70 : height * 0.2,
                                      width: width > 500 ? 400 : widthContainer,
                                      child: textForm(
                                          hintText: "العنوان",
                                          hintDirection: textDirection,
                                          textDirection: textDirection,
                                          senderController: titleController,
                                          onChange: (value) {
                                            titleController.text = value;
                                          },
                                          isContentPadding: true,
                                          cpv: padding,
                                          cph: padding,
                                          validateFunction: (_) {
                                            if (titleController.text
                                                .trim()
                                                .isEmpty)
                                              return "الرجاء وضع العنوان";
                                          },
                                          radius: 10.0)),
                                  SizedBox(
                                    height: padding,
                                  ),
                                  container(
                                      height: height > 500 ? 150 : height * 0.8,
                                      width: widthContainer,
                                      child: textForm(
                                          hintText: "الوصف",
                                          hintDirection: textDirection,
                                          type: TextInputType.multiline,
                                          senderController:
                                              descriptionController,
                                          onChange: (value) {
                                            descriptionController.text = value;
                                          },
                                          validateFunction: (_) {
                                            if (descriptionController.text
                                                .trim()
                                                .isEmpty)
                                              return "الرجاء وضع الوصف";
                                          },
                                          maxLines: 1000,
                                          isContentPadding: true,
                                          cph: padding,
                                          cpv: padding,
                                          textDirection: textDirection)),
                                  SizedBox(
                                    height: padding,
                                  ),
                                  subjectPicker(height, width, widthContainer),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                ],
                              ),
                            )),
                      ))),
        drawerKey,
        "video");
  }
}
