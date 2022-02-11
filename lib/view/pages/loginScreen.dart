import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:junior_project/controller/userController.dart';
import 'package:junior_project/view/widget/alertDialog.dart';

import '../widget/textForm.dart';

import '../../data.dart';
import '../widget/container.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  GlobalKey<FormState> key = new GlobalKey<FormState>();
  final UserController c = Get.find<UserController>();

  TextEditingController userNameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController fullNameController = new TextEditingController();
  TextEditingController fatherController = new TextEditingController();
  TextEditingController motherController = new TextEditingController();
  Color textFieldColor = Color(0xffF7F7F7);
  bool validUsername = true;
  bool validPassword = true;

  dynamic userNameValidation(_) {
    if (userNameController.text.trim().isEmpty) {
      validUsername = false;

      return "username must not be empty";
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

  bool validFullName = true;
  dynamic fullnameValidation(_) {
    if (fullNameController.text.trim().isEmpty) {
      validFullName = false;

      return "يرجى كتابة الاسم كامل";
    } else {
      validFullName = true;

      return null;
    }
  }

  bool validMotherName = true;
  dynamic motherNameValidation(_) {
    if (motherController.text.trim().isEmpty) {
      validMotherName = false;

      return "يرجى كتابة اسم الام";
    } else {
      validMotherName = true;

      return null;
    }
  }

  bool validFatherName = true;
  dynamic fatherNameValidation(_) {
    if (fatherController.text.trim().isEmpty) {
      validFatherName = false;

      return "يرحى كتابة اسم الاب";
    } else {
      validFatherName = true;

      return null;
    }
  }

  bool isSignedIn = true;

  Widget validation(containerWidth, containerHeight, text,
      {TextDirection direction = TextDirection.ltr}) {
    return container(
        width: containerWidth,
        height: containerHeight,
        radius: textFieldRadius,
        padding: padding,
        color: Colors.yellow[300],
        child: AutoSizeText(
          text,
          textDirection: direction,
          style: TextStyle(color: Colors.red),
        ));
  }

  void click_me(context) {
    if (key.currentState != null) {
      if (key.currentState.validate() && validUsername && validPassword) {
        if (!isSignedIn &&
                validFatherName &&
                validMotherName &&
                validFullName ||
            isSignedIn) {
          (isSignedIn
                  ? c.signIn(
                      username: userNameController.text,
                      password: passwordController.text)
                  : c.sign_up(
                      username: userNameController.text,
                      password: passwordController.text,
                      fullName: fullNameController.text,
                      motherName: motherController.text,
                      fatherName: fatherController.text))
              .then((value) {
            if (value["error"]) {
              showAlertDialog(context,
                  content: Text(value["msg"] +
                      "\n" +
                      ((value.containsKey("errors") && value["errors"] != null)
                          ? (value["errors"].containsKey("username")
                              ? value["errors"]["username"][0]
                              : value["errors"].containsKey("password")
                                  ? value["errors"]["password"][0]
                                  : value["errors"].containsKey("full_name")
                                      ? value["errors"]["full_name"][0]
                                      : value["errors"]
                                              .containsKey("mother_name")
                                          ? value["errors"]["mother_name"][0]
                                          : value["errors"]
                                                  .containsKey("father_name")
                                              ? value["errors"]["father_name"]
                                                  [0]
                                              : "")
                          : "")),
                  action: [
                    FlatButton(
                        onPressed: () {
                          return Navigator.of(context).pop();
                        },
                        child: Text("ok"))
                  ]);
            } else {
              Get.showSnackbar(GetSnackBar(
                title: "message",
                message: "login successfully",
                duration: Duration(seconds: 1),
              ));
              Navigator.of(context).pushReplacementNamed('/home');
            }
          });
        } else {
          setState(() {});
        }
        // Navigator.of(context).pushReplacement(
        //     MaterialPageRoute(builder: (context) => loadingPage()));
      } else {
        setState(() {});
      }
    }
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
                  child: Center(
                      child: SingleChildScrollView(
                          padding: EdgeInsets.only(
                              bottom: padding, top: height * 0.1),
                          child: Column(
                            children: [
                              Image.asset(
                                logoImage,
                                height: height > 500 ? 100 : height * 0.3,
                                width: width > 500 ? 100 : width * 0.5,
                              ),
                              !isSignedIn
                                  ? container(
                                      width: containerWidth,
                                      height: containerHeight,
                                      child: textForm(
                                          senderController: fullNameController,
                                          textDirection: TextDirection.rtl,
                                          hintDirection: TextDirection.rtl,
                                          validateFunction: fullnameValidation,
                                          type: TextInputType.name,
                                          radius: textFieldRadius,
                                          cursorColor: cursorColor,
                                          color: textFieldColor,
                                          isContentPadding: true,
                                          cpv: height > 500
                                              ? padding
                                              : height * 0.06,
                                          cph: 15.0,
                                          hintText: "اسم الكامل"))
                                  : SizedBox(),
                              isSignedIn
                                  ? SizedBox()
                                  : !validFullName
                                      ? validation(
                                          containerWidth,
                                          containerHeight,
                                          "يرجى كتابة الاسم كامل",
                                          direction: TextDirection.rtl)
                                      : SizedBox(),
                              SizedBox(height: padding),
                              !isSignedIn
                                  ? container(
                                      width: containerWidth,
                                      height: containerHeight,
                                      child: textForm(
                                          senderController: fatherController,
                                          validateFunction:
                                              fatherNameValidation,
                                          textDirection: TextDirection.rtl,
                                          hintDirection: TextDirection.rtl,
                                          type: TextInputType.name,
                                          radius: textFieldRadius,
                                          cursorColor: cursorColor,
                                          color: textFieldColor,
                                          isContentPadding: true,
                                          cpv: height > 500
                                              ? padding
                                              : height * 0.06,
                                          cph: 15.0,
                                          hintText: "اسم الاب"))
                                  : SizedBox(),
                              isSignedIn
                                  ? SizedBox()
                                  : !validFatherName
                                      ? validation(
                                          containerWidth,
                                          containerHeight,
                                          "يرجى كتابة اسم الاب",
                                          direction: TextDirection.rtl)
                                      : SizedBox(),
                              SizedBox(height: padding),
                              !isSignedIn
                                  ? container(
                                      width: containerWidth,
                                      height: containerHeight,
                                      child: textForm(
                                          senderController: motherController,
                                          validateFunction:
                                              motherNameValidation,
                                          textDirection: TextDirection.rtl,
                                          hintDirection: TextDirection.rtl,
                                          type: TextInputType.name,
                                          radius: textFieldRadius,
                                          cursorColor: cursorColor,
                                          color: textFieldColor,
                                          isContentPadding: true,
                                          cpv: height > 500
                                              ? padding
                                              : height * 0.06,
                                          cph: 15.0,
                                          hintText: "اسم الام"))
                                  : SizedBox(),
                              isSignedIn
                                  ? SizedBox()
                                  : !validMotherName
                                      ? validation(
                                          containerWidth,
                                          containerHeight,
                                          "يرحى كتابة اسم الام",
                                          direction: TextDirection.rtl)
                                      : SizedBox(),
                              SizedBox(height: padding),
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
                                      color: textFieldColor,
                                      cpv: height > 500
                                          ? padding
                                          : height * 0.06,
                                      cph: 15.0,
                                      hintText: "username")),
                              !validUsername
                                  ? validation(containerWidth, containerHeight,
                                      "username  mustn\'t be empty")
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
                                      color: textFieldColor,
                                      cursorColor: cursorColor,
                                      isContentPadding: true,
                                      cpv: height > 500 ? 10.0 : height * 0.06,
                                      cph: 15.0)),
                              !validPassword
                                  ? validation(containerWidth, containerHeight,
                                      "password mustn\'t be  empty")
                                  : SizedBox(),
                              SizedBox(height: padding),
                              Obx(() => c.isLoading.isTrue
                                  ? CircularProgressIndicator()
                                  : RaisedButton(
                                      elevation: padding,
                                      onPressed: () {
                                        click_me(context);
                                      },
                                      child: Text(
                                        isSignedIn ? "sign in" : "sign up",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      padding: EdgeInsets.all(padding),
                                      color: raisedButtonColor,
                                      shape: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              style: BorderStyle.none),
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(
                                                  raisedButtonRadius),
                                              bottomRight: Radius.circular(
                                                  raisedButtonRadius))),
                                    )),
                              FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      isSignedIn = !isSignedIn;
                                    });
                                  },
                                  child: Text("switch to " +
                                      (isSignedIn ? "sign up" : "sign in")))
                            ],
                          ))))),
        ));
  }
}
