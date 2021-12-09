import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../widget/textForm.dart';
import '../widget/raisedButton.dart';
import '../../data.dart';
import '../widget/container.dart';
import '../widget/dropdownButton.dart';
import 'loadingScreen.dart';

class loginPage extends StatefulWidget {
  @override
  State<loginPage> createState() => _loginPage();
}

class _loginPage extends State<loginPage> {
  GlobalKey<FormState> key = new GlobalKey<FormState>();
  String dropdownValue = "student";
  TextEditingController userNameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  List<DropdownMenuItem> items = [
    DropdownMenuItem(value: "student", child: Text("student")),
    DropdownMenuItem(value: "teacher", child: Text("teacher")),
    DropdownMenuItem(value: "manger", child: Text("manger"))
  ];

  bool validUsername = true;
  bool validPassword = true;

  dynamic userNameValidation(_) {
    if (userNameController.text.trim().isEmpty ||
        !RegExp(r"[a-zA-Z]([a-zA-Z]| )+")
            .hasMatch(userNameController.text.trim())) {
      validUsername = false;

      return "username must be consist of only characters and not empty";
    } else {
      validUsername = true;

      return null;
    }
  }

  dynamic passwordValidation(_) {
    if (passwordController.text.trim().isEmpty) {
      validPassword = false;

      return "password mustn\'t be  empty";
    } else {
      validPassword = true;

      return null;
    }
  }

  void signIn() {
    if (key.currentState.validate() && validUsername && validPassword) {
      Navigator.of(context).pushReplacementNamed('/home');
      // Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(builder: (context) => loadingPage()));
    } else {
      setState(() {});
    }
  }

  void dropDownOnChange(dynamic value) {
    setState(() {
      dropdownValue = value;
    });
  }

  Widget validation(containerWidth, containerHeight, text) {
    return container(
        width: containerWidth,
        height: containerHeight,
        radius: textFieldRadius,
        padding: padding,
        color: Colors.yellow[300],
        child: AutoSizeText(
          text,
          style: TextStyle(color: Colors.red),
        ));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double containerWidth = width > 500 ? 500 : width * 0.8;
    double containerHeight = height > 500 ? 50 : height * 0.15;
    return GestureDetector(
        onTap: () {
          return FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          body: container(
              width: width,
              height: height,
              image: AssetImage(logingInImage),
              child: Form(
                  key: key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        logoImage,
                        height: height > 500 ? 100 : height * 0.3,
                        width: width > 500 ? 100 : width * 0.5,
                      ),
                      container(
                          width: containerWidth,
                          height: containerHeight,
                          child: textForm(
                              senderController: userNameController,
                              validateFunction: userNameValidation,
                              type: TextInputType.name,
                              radius: textFieldRadius,
                              cursorColor: cursorColor,
                              isContentPadding: true,
                              cpv: height > 500 ? padding : height * 0.06,
                              cph: 15.0,
                              hintText: "username")),
                      !validUsername
                          ? validation(containerWidth, containerHeight,
                              "username must be only consist of  characters and mustn\'t empty")
                          : SizedBox(),
                      SizedBox(
                        height: padding,
                      ),
                      container(
                          width: containerWidth,
                          height: containerHeight,
                          child: textForm(
                              senderController: passwordController,
                              isPassword: true,
                              validateFunction: passwordValidation,
                              hintText: "password",
                              radius: textFieldRadius,
                              cursorColor: cursorColor,
                              isContentPadding: true,
                              cpv: height > 500 ? 10.0 : height * 0.06,
                              cph: 15.0)),
                      !validPassword
                          ? validation(containerWidth, containerHeight,
                              "password mustn\'t be  empty")
                          : SizedBox(),
                      SizedBox(height: padding),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "sign in as: ",
                              style:
                                  TextStyle(fontSize: 20.0, color: Colors.red),
                            ),
                            container(
                                height: height > 500 ? 50 : height * 0.1,
                                width: width > 500 ? 150 : width * 0.3,
                                color: Colors.blue,
                                radius: textFieldRadius,
                                padding: padding,
                                child: dropDownButton(
                                    function: dropDownOnChange,
                                    initValue: dropdownValue,
                                    list: items))
                          ]),
                      normalButton(
                          function: signIn,
                          child: Text(
                            "sign in",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: raisedButtonColor,
                          radius: raisedButtonRadius)
                    ],
                  ))),
        ));
  }
}
