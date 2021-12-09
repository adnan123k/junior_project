import 'package:flutter/material.dart';

Widget backButton(context) {
  return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back_ios_outlined,
        color: Colors.black,
      ));
}
