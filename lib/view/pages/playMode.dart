import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:junior_project/view/pages/levelPages/levelListScreen.dart';
import '../../data.dart';
import '../widget/appBar.dart';
import '../widget/backButton.dart';
import '../widget/container.dart';
import 'subjectScreen.dart';

class PlayMode extends StatelessWidget {
  final challenge;

  PlayMode(this.challenge);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return container(
      height: height,
      width: width,
      image: AssetImage(background),
      opacity: 0.8,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: appBar(
            leading: backButton(),
            color: Colors.transparent,
          ),
          body: Center(
              child: SingleChildScrollView(
                  child: Column(
            children: [
              GestureDetector(
                  onTap: () {
                    Get.to(SubjectPage(
                      true,
                      challenge: challenge,
                    ));
                  },
                  child: container(
                      height: height > 500 ? height * 0.2 : height * 0.6,
                      width: width * 0.6,
                      image: AssetImage(learnImage),
                      opacity: 0.8,
                      radius: 10.0)),
              SizedBox(
                height: padding,
              ),
              GestureDetector(
                  onTap: () {
                    Get.to(LevelListPage(challenge));
                  },
                  child: container(
                      height: height > 500 ? height * 0.2 : height * 0.6,
                      width: width * 0.6,
                      image: AssetImage(playImage),
                      opacity: 0.8,
                      radius: 10.0))
            ],
          )))),
    );
  }
}
