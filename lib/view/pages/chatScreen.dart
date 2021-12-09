import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:junior_project/view/widget/appBar.dart';
import 'package:junior_project/view/widget/backButton.dart';
import 'package:junior_project/view/widget/container.dart';
import 'package:junior_project/view/widget/listView.dart';

import 'package:junior_project/view/widget/textForm.dart';

import '../../data.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPage createState() => _ChatPage();
}

class _ChatPage extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
        onTap: () {
          return FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
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
                        "ارسال",
                        style:
                            TextStyle(color: Colors.blue[900], fontSize: 25.0),
                      )),
                  container(
                      width: width * 0.7,
                      height: height > 500 ? 50 : height * 0.1,
                      radius: textFieldRadius,
                      color: Colors.transparent,
                      child: textForm(
                        radius: textFieldRadius,
                        textDirection: textDirection,
                        hintText: "محتوى الرسالة",
                        hintDirection: textDirection,
                      ))
                ],
              )),
          appBar: appBar(
              leading: backButton(context),
              color: Colors.green[400],
              elevation: 10.0),
          body: Padding(
              padding: EdgeInsets.only(
                  right: padding,
                  left: padding,
                  bottom: height > 500 ? 100 : height * 0.2),
              child: listView(
                  itemCount: 40,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: padding,
                    );
                  },
                  itemBuilder: (context, index) {
                    return Align(
                        alignment: index % 2 == 0
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: container(
                            width: width * 0.5,
                            color: index % 2 == 0 ? Colors.green : Colors.grey,
                            topLeftRadius: textFieldRadius,
                            topRightRadius: textFieldRadius,
                            bottomRightRadius:
                                index % 2 == 0 ? textFieldRadius : 0.0,
                            bottomLeftRadius:
                                index % 2 != 0 ? textFieldRadius : 0.0,
                            top: padding,
                            left: padding,
                            right: padding,
                            bottom: padding,
                            child: Text(
                              "hi",
                              textDirection: textDirection,
                            )));
                  })),
        ));
  }
}
