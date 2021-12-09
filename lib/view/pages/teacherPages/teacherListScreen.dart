import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:junior_project/view/pages/teacherPages/teacherForm.dart';
import 'package:junior_project/view/widget/alertDialog.dart';
import 'package:junior_project/view/widget/appBar.dart';
import 'package:junior_project/view/widget/container.dart';
import 'package:junior_project/view/widget/drawer.dart';
import 'package:junior_project/view/widget/listView.dart';
import 'package:junior_project/view/widget/raisedButton.dart';
import 'package:junior_project/view/widget/searchBar.dart';

import '../../../data.dart';
import 'teacherPage.dart';

class teacherListPage extends StatefulWidget {
  final isStudent;

  teacherListPage({this.isStudent = false});

  @override
  _teacherListPage createState() => _teacherListPage();
}

class _teacherListPage extends State<teacherListPage> {
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
                        return teacherForm(widget.isStudent);
                      }));
                    },
                    icon: Icon(Icons.add),
                    color: Colors.green)
              ],
              title: searchBar(width, height, null)),
          body: listView(
              itemCount: 3,
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.black,
                );
              },
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return teacherPage(widget.isStudent);
                    }));
                  },
                  leading: Text("adnan"),
                  trailing: container(
                      width: width * 0.3,
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {
                                showAlertDialog(context,
                                    content: container(
                                        height: height * 0.5,
                                        child: SingleChildScrollView(
                                            child: CheckboxGroup(
                                                labels: subjectName))),
                                    action: [
                                      normalButton(
                                          child: Text("تاكيد"),
                                          color: Colors.amber[400])
                                    ]);
                              },
                              icon: Icon(
                                  widget.isStudent ? Icons.add : Icons.edit,
                                  color: widget.isStudent
                                      ? Colors.green
                                      : Colors.grey)),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.close,
                                color: Colors.red,
                              ))
                        ],
                      )),
                );
              }),
        ),
        drawerKey,
        widget.isStudent ? "students" : "teachers");
  }
}
