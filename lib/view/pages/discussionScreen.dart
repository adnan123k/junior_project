import 'package:auto_size_text/auto_size_text.dart';
import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:flutter/material.dart';

import 'package:junior_project/view/widget/appBar.dart';
import 'package:junior_project/view/widget/backButton.dart';
import 'package:junior_project/view/widget/container.dart';
import 'package:junior_project/view/widget/drawer.dart';
import 'package:junior_project/view/widget/listView.dart';
import 'package:junior_project/view/widget/postCard.dart';

import 'package:junior_project/view/widget/textForm.dart';

import '../../data.dart';

class DiscussionPage extends StatefulWidget {
  final myDiscussion;
  DiscussionPage({this.myDiscussion = false});

  @override
  _DiscussionPageState createState() => _DiscussionPageState();
}

class _DiscussionPageState extends State<DiscussionPage> {
  var drawerKey = GlobalKey<SwipeDrawerState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return customizeDrawer(
        GestureDetector(
            onTap: () {
              return FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
                backgroundColor: Colors.blue,
                bottomSheet: container(
                    width: width,
                    height: height > 500 ? 100 : height * 0.2,
                    color: Colors.grey[400],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                            onPressed: () {},
                            child: AutoSizeText(
                              "نشر",
                              style: TextStyle(
                                  color: Colors.blue[900], fontSize: 25.0),
                            )),
                        container(
                            width: width * 0.7,
                            height: height > 500 ? 50 : height * 0.1,
                            radius: 10.0,
                            color: Colors.transparent,
                            child: textForm(
                              radius: 10.0,
                              textDirection: textDirection,
                              hintText: "محتوى المنشور",
                              hintDirection: textDirection,
                            ))
                      ],
                    )),
                appBar: appBar(
                    leading: widget.myDiscussion
                        ? InkWell(
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
                            ))
                        : backButton(context)),
                body: container(
                    width: width,
                    height: height,
                    bottom: height > 500 ? 80.0 : height * 0.2,
                    child: listView(
                        itemCount: 3,
                        separatorBuilder: (context, index) {
                          return container(
                              width: width,
                              color: Colors.blue,
                              height: padding);
                        },
                        itemBuilder: (context, index) {
                          return postCard(width, height, context);
                        })))),
        drawerKey,
        "discussion");
  }
}
