import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:junior_project/controller/videoController.dart';
import 'package:junior_project/data.dart';
import 'package:junior_project/model/lesson.dart';
import 'package:junior_project/model/video.dart';

import 'package:junior_project/view/pages/lessonPages/lessonScreen.dart';
import 'package:junior_project/view/widget/appBar.dart';
import 'package:junior_project/view/widget/backButton.dart';
import 'package:junior_project/view/widget/container.dart';
import 'package:junior_project/view/widget/listView.dart';
import 'package:junior_project/view/widget/searchBar.dart';

class SubjectPage extends StatefulWidget {
  final isLessonName;
  final challenge;

  SubjectPage(this.isLessonName, {this.challenge});

  @override
  _SubjectPage createState() => _SubjectPage();
}

class _SubjectPage extends State<SubjectPage> {
  bool isSearch = false;
  List<Lesson> searchedLesson = [];
  List<Video> searchedVideo = [];
  final VideoController _levelController = Get.put(VideoController());
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.isLessonName) searchedLesson = widget.challenge.lessons;
    if (!widget.isLessonName) {
      Timer(Duration.zero, () {
        _levelController.getLessonVideos(widget.challenge.id);
      });
    }
  }

  void searchByLessonName(String value) {
    setState(() {
      List<Lesson> temp = [];
      searchedLesson.forEach((element) {
        if (element.title.contains(value.trim())) {
          temp.add(element);
        }
      });
      searchedLesson = temp;
    });
  }

  void searchByVideoNameOrTutorName(String value) {
    setState(() {
      List<Video> temp = [];
      _levelController.lessonVideos.forEach((element) {
        if (element.title.contains(value.trim()) ||
            element.fullName.contains(value.trim())) {
          temp.add(element);
        }
      });
      searchedVideo = temp;
    });
  }

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: appBar(
          leading: backButton(),
          title: isSearch
              ? searchBar(
                  width,
                  height,
                  searchController,
                  widget.isLessonName
                      ? searchByLessonName
                      : searchByVideoNameOrTutorName)
              : SizedBox(),
          actions: [
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      setState(() {
                        isSearch = !isSearch;
                      });
                    },
                    icon: Icon(
                      isSearch ? Icons.close : Icons.search,
                      color: Colors.black,
                    )))
          ],
        ),
        body: Obx(
          () => _levelController.isLoading.isTrue
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : listView(
                  itemCount: widget.isLessonName
                      ? isSearch
                          ? searchedLesson.length
                          : widget.challenge.lessons.length
                      : isSearch
                          ? searchedVideo.length
                          : _levelController.lessonVideos.length,
                  separatorBuilder: (context, index) {
                    return Divider(
                      thickness: 2.0,
                    );
                  },
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => widget.isLessonName
                                ? SubjectPage(false,
                                    challenge: isSearch
                                        ? searchedLesson[index]
                                        : widget.challenge.lessons[index])
                                : LessonPage(
                                    isSearch
                                        ? searchedVideo[index]
                                        : _levelController.lessonVideos[index],
                                    index)));
                      },
                      trailing: container(
                          width: width * 0.8,
                          color: Colors.transparent,
                          child: AutoSizeText(
                            widget.isLessonName
                                ? isSearch
                                    ? searchedLesson[index].title
                                    : widget.challenge.lessons[index].title
                                : isSearch
                                    ? searchedVideo[index].title
                                    : _levelController
                                        .lessonVideos[index].title,
                            textDirection: textDirection,
                          )),
                      leading: container(
                        width: width * 0.2,
                        color: Colors.transparent,
                        child: widget.isLessonName
                            ? Icon(Icons.arrow_forward_ios)
                            : AutoSizeText(
                                isSearch
                                    ? searchedVideo[index].fullName
                                    : _levelController
                                        .lessonVideos[index].fullName,
                                textDirection: textDirection,
                              ),
                      ),
                      focusColor: Colors.blue,
                    );
                  }),
        ));
  }
}
