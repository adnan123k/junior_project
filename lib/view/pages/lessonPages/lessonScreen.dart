import 'package:flutter/material.dart';
import 'package:junior_project/view/pages/discussionScreen.dart';
import 'package:junior_project/view/widget/appBar.dart';
import 'package:junior_project/view/widget/backButton.dart';
import 'package:junior_project/view/widget/container.dart';
import 'package:junior_project/view/widget/raisedButton.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import '../../../data.dart';

import 'lessonForm.dart';

class lessonPage extends StatefulWidget {
  @override
  State<lessonPage> createState() => _lessonPage();
}

class _lessonPage extends State<lessonPage> {
  final videoPlayerController = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
  ChewieController chewieController;

  bool firstTime = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initVideo();
  }

  void initVideo() async {
    await videoPlayerController.initialize();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (videoPlayerController != null) {
      chewieController = ChewieController(
          videoPlayerController: videoPlayerController,
          allowMuting: false,
          allowedScreenSleep: false,
          aspectRatio: 16 / 9);

      videoPlayerController.addListener(() async {
        if (videoPlayerController.value.position.inSeconds == 4 &&
            videoPlayerController.value.isPlaying &&
            firstTime) {
          firstTime = false;

          await videoPlayerController.pause();
          await chewieController.pause().then((value) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text("it works!!"),
                    contentPadding: EdgeInsets.all(padding),
                    actions: [
                      FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("ok"))
                    ],
                  );
                }).then((value) async {
              await videoPlayerController.play();
              await chewieController.play();
            });
          });
        }
      });
    }
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  Widget discussionSection() {
    return Padding(
        padding: EdgeInsets.only(right: padding * 3),
        child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              "",
              textDirection: textDirection,
            )));
  }

  Widget videoSection(height, width) {
    return container(
        height: height * 0.3,
        width: width * 0.8,
        child: chewieController == null
            ? LinearProgressIndicator()
            : Chewie(controller: chewieController));
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
                    .push(MaterialPageRoute(builder: (context) {
                  return lessonForm();
                }));
              },
              child: container(
                  width: 15.0,
                  height: 10.0,
                  child: Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ))),
          container(
              width: 10.0,
              height: 10.0,
              child: Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: appBar(leading: backButton(context), actions: [
        normalButton(
            elevation: 0.0,
            child: Text(
              "مناقشة",
              textDirection: textDirection,
              style: TextStyle(color: Colors.blue),
            ),
            color: Colors.transparent,
            function: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DiscussionPage()));
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
                editAndDelete(width),
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
  }
}
