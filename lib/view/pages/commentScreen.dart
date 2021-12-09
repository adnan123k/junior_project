import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:junior_project/view/widget/appBar.dart';
import 'package:junior_project/view/widget/backButton.dart';
import 'package:junior_project/view/widget/container.dart';
import 'package:junior_project/view/widget/listView.dart';
import 'package:junior_project/view/widget/postCard.dart';
import 'package:junior_project/view/widget/textForm.dart';

import '../../data.dart';

class CommentPage extends StatefulWidget {
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  FocusNode commentNode = FocusNode();

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
                          "تعليق",
                          style: TextStyle(
                              color: Colors.blue[900], fontSize: 25.0),
                        )),
                    container(
                        width: width * 0.7,
                        height: height > 500 ? 50 : height * 0.1,
                        radius: 10.0,
                        color: Colors.transparent,
                        child: textForm(
                            radius: 10.0,
                            textDirection: textDirection,
                            hintText: "محتوى التعليق",
                            hintDirection: textDirection,
                            focusNode: commentNode))
                  ],
                )),
            appBar: appBar(leading: backButton(context)),
            body: container(
                width: width,
                height: height,
                bottom: height > 500 ? 80.0 : height * 0.2,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      postCard(width, height, context),
                      container(
                          width: width,
                          color: Colors.grey[400],
                          child: Padding(
                              padding: EdgeInsets.all(padding),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: AutoSizeText(
                                    "التعليقات",
                                    style: TextStyle(fontSize: 30.0),
                                    textDirection: textDirection,
                                  )))),
                      container(
                          width: width,
                          height: height * 0.8,
                          color: Colors.grey,
                          child: listView(
                              physcis: NeverScrollableScrollPhysics(),
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: padding,
                                );
                              },
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                return container(
                                    width: width,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        cardHeader(width, height, context),
                                        cardBody(),
                                        container(
                                            width: width,
                                            height: height * 0.1,
                                            child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: FlatButton(
                                                  child: AutoSizeText(
                                                    "اعجاب",
                                                    textDirection:
                                                        textDirection,
                                                  ),
                                                )))
                                      ],
                                    ));
                              })),
                    ],
                  ),
                ))));
  }
}
