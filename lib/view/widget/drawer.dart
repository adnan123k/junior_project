import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/userController.dart';
import '../../data.dart';

class customizeDrawer extends StatefulWidget {
  final Widget child;
  final drawerKey;
  final String selected;
  customizeDrawer(this.child, this.drawerKey, this.selected);
  @override
  State<customizeDrawer> createState() => _customizeDrawer();
}

class _customizeDrawer extends State<customizeDrawer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // add this line so you can add your appBar in Body
      extendBodyBehindAppBar: true,
      body: SwipeDrawer(
        radius: 20,
        key: widget.drawerKey,

        hasClone: false,
        bodyBackgroundPeekSize: 30,
        backgroundColor: drawerColor,
        // pass drawer widget
        drawer: buildDrawer(),
        // pass body widget
        child: widget.child,
      ),
    );
  }

  final UserController c = Get.find<UserController>();
  Widget buildDrawer() {
    return Container(
        child: Center(
            child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            selected: widget.selected == "home",
            leading: Icon(Icons.home),
            title: Text(
              'منزل',
              textDirection: textDirection,
            ),
            onTap: () {
              Get.offAndToNamed('/home');
            },
          ),
          c.currentUser.value.type != "admin" ? SizedBox() : Divider(),
          c.currentUser.value.type != "admin"
              ? SizedBox()
              : ListTile(
                  selected: widget.selected == "teachers",
                  leading: Icon(Icons.school_sharp),
                  title: Text('معلمين', textDirection: textDirection),
                  onTap: () {
                    Get.offAndToNamed('/teacher');
                  }),
          c.currentUser.value.type != "teacher" ? SizedBox() : Divider(),
          c.currentUser.value.type != "teacher"
              ? SizedBox()
              : ListTile(
                  selected: widget.selected == "video",
                  leading: Icon(Icons.video_call),
                  title: Text('اضافة درس', textDirection: textDirection),
                  onTap: () {
                    Get.offAndToNamed('/video');
                  },
                ),
          Divider(),
          ListTile(
            selected: widget.selected == "best students",
            leading: Icon(Icons.star),
            title: Text(
              'افضل ١٠ طلاب',
              textDirection: textDirection,
            ),
            onTap: () {
              Get.offAndToNamed('/topStudents');
            },
          ),
          Divider(),
          ListTile(
              selected: widget.selected == "discussion",
              leading: Icon(Icons.poll_sharp),
              title: Text('مناقشات', textDirection: textDirection),
              onTap: () {
                Get.offAndToNamed('/discussion');
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.input_outlined),
              title: Text('تسجيل خروج', textDirection: textDirection),
              onTap: () {
                c.signOut();
              }),
        ],
      ),
    )));
  }
}
