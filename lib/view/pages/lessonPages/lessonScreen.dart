import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:junior_project/controller/userController.dart';
import 'package:junior_project/controller/videoController.dart';
import 'package:junior_project/view/pages/discussionScreen.dart';
import 'package:junior_project/view/widget/appBar.dart';
import 'package:junior_project/view/widget/backButton.dart';
import 'package:junior_project/view/widget/container.dart';
import 'package:junior_project/view/widget/raisedButton.dart';
import 'package:chewie/chewie.dart';

import 'package:video_player/video_player.dart';

import '../../../data.dart';

import 'lessonForm.dart';

class LessonPage extends StatefulWidget {
  final video;
  final index;

  LessonPage(this.video, this.index);
  @override
  State<LessonPage> createState() => _LessonPage();
}

class _LessonPage extends State<LessonPage> {
  VideoPlayerController videoPlayerController = null;
  ChewieController chewieController;
  // final FijkPlayer player = FijkPlayer();
  bool firstTime = true;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    Timer(Duration.zero, () {
      setState(() {
        print(widget.video.url);
        videoPlayerController = VideoPlayerController.network(widget.video.url)
          ..addListener(() {
            if (videoPlayerController.value.position.inSeconds ==
                    videoPlayerController.value.duration.inSeconds &&
                !isDone &&
                videoPlayerController.value.duration.inSeconds != 0) {
              if (_userController.currentUser.value.type == "student") {
                _userController.updatePoint(1);
                isDone = true;
              }
            }
          });
        // player.setDataSource(widget.video.url, autoPlay: true);
        // player.setLoop(6);
        chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          allowMuting: false,
          allowedScreenSleep: false,
          aspectRatio: 16 / 9,
          errorBuilder: (context, errorMessage) {
            return Text(
              errorMessage,
              style: TextStyle(color: Colors.white),
            );
          },
        );
        // videoPlayerController.addListener(() async {
        //   if (videoPlayerController.value.position.inSeconds == 4 &&
        //       videoPlayerController.value.isPlaying &&
        //       firstTime) {
        //     firstTime = false;

        //     await videoPlayerController.pause();
        //     await chewieController.pause().then((value) {
        //       showDialog(
        //           context: context,
        //           builder: (context) {
        //             return AlertDialog(
        //               content: Text("it works!!"),
        //               contentPadding: EdgeInsets.all(padding),
        //               actions: [
        //                 FlatButton(
        //                     onPressed: () {
        //                       Navigator.of(context).pop();
        //                     },
        //                     child: Text("ok"))
        //               ],
        //             );
        //           }).then((value) async {
        //         await videoPlayerController.play();
        //         await chewieController.play();
        //       });
        //     });
        //   }
        // });
      });
    });
  }

  bool isDone = false;
  final UserController _userController = Get.find<UserController>();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    videoPlayerController = null;
    chewieController.dispose();
    chewieController = null;
    // player.release();
    super.dispose();
  }

  Widget discussionSection() {
    return Padding(
        padding: EdgeInsets.only(right: padding * 3),
        child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              widget.video.description,
              textDirection: textDirection,
            )));
  }

  final VideoController _videoController = Get.find<VideoController>();
  Widget videoSection(height, width) {
    return container(
        height: height * 0.3,
        width: width * 0.8,
        child: videoPlayerController == null
            ? LinearProgressIndicator()
            : Chewie(
                controller: chewieController,
              ));
  }

  Widget editAndDelete(width) {
    return container(
        width: width * 0.8,
        padding: padding,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          GestureDetector(
              onTap: () {
                return Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return LessonForm(video: widget.video);
                }));
              },
              child: container(
                  width: 15.0,
                  height: 10.0,
                  child: Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ))),
          GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                _videoController.deleteVideo(widget.index);
              },
              child: container(
                  width: 10.0,
                  height: 10.0,
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  )))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Obx(() {
      return Scaffold(
        appBar: appBar(leading: backButton(), actions: [
          normalButton(
              elevation: 0.0,
              child: Text(
                "مناقشة",
                textDirection: textDirection,
                style: TextStyle(color: Colors.blue),
              ),
              color: Colors.transparent,
              function: () {
                Get.to(DiscussionPage(id: widget.video.id));
              })
        ]),
        body: container(
            width: width,
            height: height,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  vertical: padding, horizontal: padding * 3),
              child: Column(
                children: [
                  _userController.currentUser.value.id == widget.video.teacherId
                      ? editAndDelete(width)
                      : SizedBox(),
                  Divider(),
                  videoSection(height, width),
                  Padding(
                      padding: EdgeInsets.only(right: padding * 3),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "الوصف",
                            textDirection: textDirection,
                          ))),
                  Divider(),
                  discussionSection()
                ],
              ),
            )),
      );
    });
  }
}
