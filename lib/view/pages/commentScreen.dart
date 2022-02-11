import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junior_project/controller/commentController.dart';
import 'package:junior_project/controller/discussionController.dart';
import 'package:junior_project/view/widget/appBar.dart';
import 'package:junior_project/view/widget/backButton.dart';
import 'package:junior_project/view/widget/container.dart';
import 'package:junior_project/view/widget/listView.dart';
import 'package:junior_project/view/widget/postCard.dart';
import 'package:junior_project/view/widget/textForm.dart';

import '../../controller/authController.dart';

import '../../data.dart';

class CommentPage extends StatefulWidget {
  final content;

  CommentPage(this.content);
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  FocusNode commentNode = FocusNode();
  final CommentController _commentController = Get.put(CommentController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration.zero, () {
      _commentController.getAllComments(widget.content.id);
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  TextEditingController body = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Obx(() {
      return GestureDetector(
          onTap: () {
            return FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
              bottomSheet: _commentController.isLoading.isTrue
                  ? SizedBox()
                  : container(
                      width: width,
                      height: height > 500 ? 100 : height * 0.2,
                      color: Colors.grey[400],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlatButton(
                              onPressed: () {
                                if (body.text.trim().isNotEmpty) {
                                  _commentController.postComment(
                                      widget.content.id, body.text);
                                  body.text = "";
                                }
                              },
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
                                  senderController: body,
                                  focusNode: commentNode))
                        ],
                      )),
              appBar: appBar(leading: backButton()),
              body: _commentController.isLoading.isTrue
                  ? Center(child: CircularProgressIndicator())
                  : container(
                      width: width,
                      height: height,
                      bottom: height > 500 ? 80.0 : height * 0.2,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            postCard(width, height, context, widget.content,
                                () {
                              setState(() {
                                widget.content.liked = !widget.content.liked;
                              });
                            }, () {
                              Get.back();
                              Get.find<DiscussionContoller>()
                                  .deleteDiscussion(widget.content.id);
                            }),
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
                                child: _commentController.isLoading.isTrue
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : listView(
                                        physcis: NeverScrollableScrollPhysics(),
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                            height: padding,
                                          );
                                        },
                                        itemCount: _commentController
                                            .allComments.length,
                                        itemBuilder: (context, index) {
                                          return container(
                                              width: width,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  cardHeader(
                                                      width,
                                                      height,
                                                      context,
                                                      _commentController
                                                          .allComments[index],
                                                      () {
                                                    _commentController
                                                        .deleteComment(
                                                            _commentController
                                                                .allComments[
                                                                    index]
                                                                .id);
                                                  }),
                                                  cardBody(_commentController
                                                      .allComments[index]),
                                                  container(
                                                      width: width,
                                                      height: height * 0.1,
                                                      child: Align(
                                                          alignment: Alignment
                                                              .centerRight,
                                                          child: FlatButton(
                                                            onPressed: () {
                                                              setState(() {
                                                                _commentController
                                                                        .allComments[
                                                                            index]
                                                                        .liked =
                                                                    !_commentController
                                                                        .allComments[
                                                                            index]
                                                                        .liked;
                                                                _commentController.putLikeOnComment(
                                                                    _commentController
                                                                        .allComments[
                                                                            index]
                                                                        .id);
                                                              });
                                                            },
                                                            child: AutoSizeText(
                                                              "اعجاب",
                                                              style: TextStyle(
                                                                  color: _commentController
                                                                          .allComments[
                                                                              index]
                                                                          .liked
                                                                      ? Colors
                                                                          .blue
                                                                      : Colors
                                                                          .grey),
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
    });
  }
}
