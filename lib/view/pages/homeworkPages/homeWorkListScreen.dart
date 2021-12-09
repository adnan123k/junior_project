import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:flutter/material.dart';
import 'package:junior_project/data.dart';
import 'package:junior_project/view/pages/lessonPages/lessonForm.dart';

import 'package:junior_project/view/widget/appBar.dart';
import 'package:junior_project/view/widget/container.dart';
import 'package:junior_project/view/widget/drawer.dart';
import 'package:junior_project/view/widget/listView.dart';

import 'homeWorkScreen.dart';

class homeWorkListPage extends StatefulWidget {
  @override
  _homeWorkListPage createState() => _homeWorkListPage();
}

class _homeWorkListPage extends State<homeWorkListPage> {
  var drawerKey = GlobalKey<SwipeDrawerState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return lessonForm(
                          isHomeWork: true,
                        );
                      }));
                    },
                    icon: Icon(Icons.add),
                    color: Colors.green)
              ]),
          body: listView(
              separatorBuilder: (context, index) {
                return Divider(color: Colors.black);
              },
              itemCount: 3,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return homeWorkPage(0);
                    }));
                  },
                  leading: container(
                      width: width * 0.6,
                      color: Colors.transparent,
                      child: Text(
                        "hi",
                        textDirection: textDirection,
                      )),
                  trailing: Icon(Icons.arrow_forward_ios),
                );
              }),
        ),
        drawerKey,
        "homework");
  }
}
