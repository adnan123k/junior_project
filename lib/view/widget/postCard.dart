import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:junior_project/view/pages/commentScreen.dart';
import './container.dart';
import './raisedButton.dart';

import '../../data.dart';

int points = 0;
Future<void> showPointDialog(height, width, context) {
  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: container(
                height: height * 0.2,
                width: width * 0.5,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          if (points != 0)
                            setState(() {
                              points++;
                            });
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.green,
                          size: 30.0,
                        )),
                    AutoSizeText(
                      points.toString(),
                      style: TextStyle(fontSize: 30.0),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            points--;
                          });
                        },
                        icon: Icon(
                          Icons.exposure_minus_1,
                          color: Colors.red,
                          size: 30.0,
                        ))
                  ],
                )),
            actions: [
              normalButton(
                  function: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.amber[400],
                  child: Text("تاكيد"))
            ],
          );
        });
      });
}

Widget cardHeader(width, height, context) {
  return container(
      width: width,
      height: height * 0.1,
      right: padding,
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        IconButton(
            icon: Icon(
          Icons.delete,
          color: Colors.red,
        )),
        FlatButton(
          onPressed: () async {
            await showPointDialog(height, width, context);
          },
          child: AutoSizeText("تنقيص نقاط",
              textDirection: textDirection,
              style: TextStyle(color: Colors.blue)),
        ),
        AutoSizeText(
          "نشر من قبل محمد",
          textDirection: textDirection,
          textAlign: TextAlign.right,
        )
      ]));
}

Widget cardBottom(width, height, context) {
  return container(
      width: width,
      height: height * 0.1,
      child: Row(
        children: [
          container(
              width: width * 0.5,
              height: height > 500 ? 50 : height * 0.1,
              child: IconButton(icon: Icon(Icons.thumb_up))),
          container(
              width: width * 0.4,
              height: height * 0.1,
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return CommentPage();
                    }));
                  },
                  icon: Icon(Icons.comment)))
        ],
      ));
}

Widget cardBody() {
  return Padding(
      padding: EdgeInsets.all(padding),
      child: AutoSizeText(
        "ijijijijiijnjnjnjnjnjnjnjnjnjjnjjnjnnnjnnnjnjnjnjnj",
        textDirection: textDirection,
        textAlign: TextAlign.right,
      ));
}

Widget postCard(width, height, context) {
  return Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        cardHeader(width, height, context),
        cardBody(),
        Align(
            alignment: Alignment.bottomCenter,
            child: cardBottom(width, height, context))
      ],
    ),
  );
}
