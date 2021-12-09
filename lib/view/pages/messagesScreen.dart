import 'package:auto_size_text/auto_size_text.dart';
import 'package:drawer_swipe/drawer_swipe.dart';
import 'package:flutter/material.dart';
import 'package:junior_project/data.dart';
import 'package:junior_project/view/pages/chatScreen.dart';
import 'package:junior_project/view/widget/alertDialog.dart';
import 'package:junior_project/view/widget/appBar.dart';
import 'package:junior_project/view/widget/container.dart';
import 'package:junior_project/view/widget/drawer.dart';
import 'package:junior_project/view/widget/listView.dart';

class messagesPage extends StatefulWidget {
  @override
  _messagesPage createState() => _messagesPage();
}

class _messagesPage extends State<messagesPage> {
  var drawerKey = GlobalKey<SwipeDrawerState>();

  void goToChat() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ChatPage();
    }));
  }

  void newMessage(height, width) {
    showAlertDialog(context,
        content: container(
            height: height * 0.8,
            width: width * 0.8,
            child: listView(
                itemCount: 10,
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colors.black,
                  );
                },
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: goToChat,
                    leading: AutoSizeText(
                      "محمد",
                      textDirection: textDirection,
                      style: TextStyle(fontSize: height * 0.1),
                    ),
                  );
                })));
  }

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
                      newMessage(height, width);
                    },
                    icon: Icon(
                      Icons.local_post_office_outlined,
                      color: Colors.blue,
                      size: height > 500 ? 30 : height * 0.1,
                    ))
              ]),
          body: listView(
              itemCount: 10,
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.black,
                );
              },
              itemBuilder: (context, index) {
                return container(
                    height: height * 0.1,
                    child: ListTile(
                        onTap: goToChat,
                        leading: AutoSizeText(
                          "محمد",
                          textDirection: textDirection,
                          style: TextStyle(fontSize: height * 0.1),
                        ),
                        trailing: Icon(
                          Icons.circle,
                          color: Colors.red[800],
                          size: 20.0,
                        ),
                        subtitle: Text(
                          "٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧ررررررررررررررررررررررررررررررررررررر٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧ررررررررررررررررررررررررررررررررررررر٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧ررررررررررررررررررررررررررررررررررررر٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧ررررررررررررررررررررررررررررررررررررر٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧ررررررررررررررررررررررررررررررررررررر٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧ررررررررررررررررررررررررررررررررررررر٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧٧رررررررررررررررررررررررررررررررررررررررررررررjiojijijijiررررررررررررررررررkjkkkjkjkjkjkjkjkjkjkjkjkjkjkjkjkjjkjkjkjkjرررررررر",
                          textDirection: textDirection,
                          softWrap: true,
                        )));
              }),
        ),
        drawerKey,
        "messages");
  }
}
