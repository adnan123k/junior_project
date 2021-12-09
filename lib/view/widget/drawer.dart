import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:flutter/material.dart';

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
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          Divider(),
          ListTile(
            selected: widget.selected == "messages",
            leading: Icon(Icons.message_outlined),
            title: Text('رسائل', textDirection: textDirection),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/messages');
            },
          ),
          Divider(),
          ListTile(
              selected: widget.selected == "students",
              leading: Icon(Icons.school_outlined),
              title: Text(
                'طلاب',
                textDirection: textDirection,
              ),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/student');
              }),
          Divider(),
          ListTile(
              selected: widget.selected == "teachers",
              leading: Icon(Icons.school_sharp),
              title: Text('معلمين', textDirection: textDirection),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/teacher');
              }),
          Divider(),
          ListTile(
            selected: widget.selected == "video",
            leading: Icon(Icons.video_call),
            title: Text('اضافة درس', textDirection: textDirection),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/video');
            },
          ),
          Divider(),
          ListTile(
              selected: widget.selected == "homework",
              leading: Icon(Icons.home_work_outlined),
              title: Text('وظائف', textDirection: textDirection),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/homework');
              }),
          Divider(),
          ListTile(
            selected: widget.selected == "best students",
            leading: Icon(Icons.star),
            title: Text(
              'افضل ١٠ طلاب',
              textDirection: textDirection,
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/topStudents');
            },
          ),
          Divider(),
          ListTile(
              selected: widget.selected == "discussion",
              leading: Icon(Icons.poll_sharp),
              title: Text('مناقشات', textDirection: textDirection),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/discussion');
              }),
          Divider(),
          ListTile(
              selected: widget.selected == "notification",
              leading: Icon(Icons.notification_important),
              title: Text('اعلانات', textDirection: textDirection),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/notification');
              }),
          Divider(),
          ListTile(
              leading: Icon(Icons.input_outlined),
              title: Text('تسجيل خروج', textDirection: textDirection),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              }),
        ],
      ),
    )));
  }
}
