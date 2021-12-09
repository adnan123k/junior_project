import 'dart:io';

import 'package:flutter/material.dart';
import 'package:junior_project/data.dart';
import 'package:flutter/animation.dart';

class loadingPage extends StatefulWidget {
  // final path;
  String errorMessage;
  bool withAnimation;
  loadingPage({this.errorMessage = "", this.withAnimation = true});
  @override
  State<loadingPage> createState() => _loadingPage();
}

class _loadingPage extends State<loadingPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  Animation<double> animation;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (widget.errorMessage == "") {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        } else {
          print("hi");
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => loadingPage(
                    errorMessage: "لا يوجد اتصال",
                  )));
        }
      } on SocketException catch (_) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => loadingPage(
                  errorMessage: "لا يوجد اتصال",
                )));
      }
    }

    //The connection status changed send out an update to all listeners

    if (widget.withAnimation && widget.errorMessage == "") {
      double height = MediaQuery.of(context).size.height;
      animationController = AnimationController(
          duration: const Duration(seconds: 3), vsync: this);
      animation = Tween<double>(begin: 0, end: height * 0.1)
          .animate(animationController)
            ..addListener(() {
              setState(() {});
            });
      animationController.repeat();
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: widget.errorMessage != ""
          ? Center(child: Text(widget.errorMessage))
          : widget.withAnimation
              ? Transform.translate(
                  offset:
                      Offset(0.0, animation == null ? 0.0 : animation.value),
                  child: Center(
                      child: Image.asset(logoImage,
                          width: width * 0.2, height: height * 0.2)),
                )
              : Center(
                  child: Image.asset(logoImage,
                      width: width * 0.2, height: height * 0.2)),
    );
  }
}
