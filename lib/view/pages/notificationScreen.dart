import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:flutter/material.dart';
import 'package:junior_project/data.dart';
import 'package:junior_project/view/widget/appBar.dart';
import 'package:junior_project/view/widget/drawer.dart';
import 'package:junior_project/view/widget/listView.dart';

class notificationpage extends StatefulWidget {
  @override
  _notificationpage createState() => _notificationpage();
}

class _notificationpage extends State<notificationpage> {
  var drawerKey = GlobalKey<SwipeDrawerState>();
  List<String> dummy = ["hi", "how are", "you", "?"];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return customizeDrawer(
        Scaffold(
          backgroundColor: Color(0xff316B83),
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
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: padding,
                );
              },
              itemCount: dummy.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                dummy.removeAt(index);
                              });
                            },
                            icon: Icon(Icons.close)),
                        Padding(
                            padding: EdgeInsets.all(padding),
                            child: Text(
                              dummy[index],
                              textDirection: textDirection,
                              style: TextStyle(fontSize: 20.0),
                            ))
                      ],
                    ),
                  ),
                );
              }),
        ),
        drawerKey,
        "notification");
  }
}
