import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junior_project/controller/userController.dart';

import 'package:junior_project/view/pages/commentScreen.dart';
import '../../controller/authController.dart';
import './container.dart';

import '../../data.dart';

final UserController _userController = Get.find<UserController>();
Widget cardHeader(width, height, context, content, fun) {
  return container(
      width: width,
      height: height * 0.1,
      right: padding,
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        (_userController.currentUser.value.userName == content.userName ||
                _userController.currentUser.value.type == "teacher")
            ? IconButton(
                onPressed: fun,
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ))
            : SizedBox(),
        _userController.currentUser.value.type != "teacher"
            ? SizedBox()
            : FlatButton(
                onPressed: () {
                  _userController.blockUser(content.user_id).then((value) {
                    if (value) fun();
                  });
                },
                child: AutoSizeText("حظر",
                    textDirection: textDirection,
                    style: TextStyle(color: Colors.red)),
              ),
        AutoSizeText(
          "نشر من قبل " + content.userName,
          textDirection: textDirection,
          textAlign: TextAlign.right,
        )
      ]));
}

Widget cardBottom(width, height, context, content, fun) {
  return container(
      width: width,
      height: height * 0.1,
      child: Row(
        children: [
          container(
              width: width * 0.5,
              height: height > 500 ? 50 : height * 0.1,
              child: IconButton(
                  onPressed: fun,
                  icon: Icon(
                    Icons.thumb_up,
                    color: content.liked ? Colors.blue : Colors.grey,
                  ))),
          container(
              width: width * 0.4,
              height: height * 0.1,
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return CommentPage(content);
                    }));
                  },
                  icon: Icon(Icons.comment)))
        ],
      ));
}

Widget cardBody(content) {
  return Padding(
      padding: EdgeInsets.all(padding),
      child: AutoSizeText(
        content.body,
        textDirection: textDirection,
        textAlign: TextAlign.right,
      ));
}

Widget postCard(width, height, context, content, fun, fun2) {
  return Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        cardHeader(width, height, context, content, fun2),
        cardBody(content),
        Align(
            alignment: Alignment.bottomCenter,
            child: cardBottom(width, height, context, content, fun))
      ],
    ),
  );
}
