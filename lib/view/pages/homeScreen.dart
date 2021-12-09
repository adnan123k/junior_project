import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:flutter/material.dart';
import 'package:junior_project/view/widget/appBar.dart';
import '../../data.dart';
import '../widget/drawer.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../widget/container.dart';
import 'subjectScreen.dart';

class homePage extends StatefulWidget {
  @override
  State<homePage> createState() => _homePage();
}

class _homePage extends State<homePage> {
  var drawerKey = GlobalKey<SwipeDrawerState>();
  double opacity = 0.7;
  double radius = 10.0;
  double width = 0.0;
  double height = 0.0;

  double containerWidth = 0.0;
  double containerHeight = 0.0;

  double fontSize = 0.0;
  double containerPadding = 0.0;

  List<Widget> subjects = new List<Widget>();

  Widget subject({
    int i,
    containerPadding,
    fontSize,
  }) {
    return Padding(
        padding: EdgeInsets.all(containerPadding),
        child: Align(
            alignment: Alignment.topRight,
            child: AutoSizeText(
              subjectName[i],
              style: TextStyle(fontSize: fontSize, color: Colors.red),
              textDirection: textDirection,
            )));
  }

  void initalizeSubject() {
    if (subjects.isEmpty) {
      for (int i = 0; i < 9; i++) {
        subjects.add(GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return subjectPage();
              }));
            },
            child: container(
              width: containerWidth,
              height: containerHeight,
              child: subject(
                  i: i, containerPadding: containerPadding, fontSize: fontSize),
              image: AssetImage(subjectImage[i]),
              opacity: opacity,
              radius: radius,
            )));
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    containerWidth = width > 500 ? width * 0.2 : width * 0.4;
    containerHeight = height > 500 ? height * 0.4 : height * 0.2;
    fontSize = width * 0.1;
    containerPadding = width > 500 ? padding * 4 : padding * 2;
    initalizeSubject();
  }

  bool thereAlert = true;
  @override
  Widget build(BuildContext context) {
    return customizeDrawer(
        Scaffold(
          appBar: appBar(
            leading: InkWell(
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
                )),
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: AutoSizeText(
                      "نقاط: 0",
                      textDirection: textDirection,
                      style: TextStyle(fontSize: 25.0, color: Colors.black),
                    ),
                  ))
            ],
          ),
          body: container(
              width: width,
              height: height,
              child: SingleChildScrollView(
                  child: Column(children: [
                thereAlert
                    ? container(
                        height: height > 500 ? height * 0.1 : height * 0.2,
                        width: width * 0.9,
                        color: Colors.blue,
                        child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      thereAlert = false;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.black,
                                  )),
                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: padding),
                                  child: AutoSizeText("هنا منطقة الاعلان",
                                      textDirection: textDirection))
                            ])))
                    : SizedBox(),
                container(
                    width: width,
                    height: height * 0.8,
                    child: GridView.count(
                      padding: EdgeInsets.only(
                          top: padding,
                          left: padding,
                          right: padding,
                          bottom: padding * 2.5),
                      crossAxisCount: 2,
                      mainAxisSpacing: padding,
                      crossAxisSpacing: padding,
                      children: subjects,
                    ))
              ]))),
        ),
        drawerKey,
        "home");
  }
}
