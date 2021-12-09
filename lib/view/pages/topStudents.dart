import 'package:auto_size_text/auto_size_text.dart';
import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:flutter/material.dart';
import 'package:junior_project/data.dart';
import 'package:junior_project/view/widget/appBar.dart';

import 'package:junior_project/view/widget/drawer.dart';
import 'package:junior_project/view/widget/listView.dart';

class topStudents extends StatefulWidget {
  @override
  _topStudents createState() => _topStudents();
}

class _topStudents extends State<topStudents> {
  var drawerKey = GlobalKey<SwipeDrawerState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

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
          ),
          body: listView(
              itemCount: 10,
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.black,
                );
              },
              itemBuilder: (context, index) {
                return ListTile(
                  leading: AutoSizeText(
                    "محمد",
                    textDirection: textDirection,
                    style: TextStyle(fontSize: height * 0.2),
                  ),
                  trailing: AutoSizeText(
                    "النقاط:٠",
                    textDirection: textDirection,
                    style: TextStyle(fontSize: height * 0.2),
                  ),
                );
              }),
        ),
        drawerKey,
        "best students");
  }
}
