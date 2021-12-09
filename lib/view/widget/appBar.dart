import 'package:flutter/material.dart';

Widget appBar(
    {leading = null,
    actions = null,
    title = null,
    color = Colors.transparent,
    elevation = 0.0}) {
  return AppBar(
    backgroundColor: color,
    elevation: elevation,
    leading: leading,
    actions: actions,
    title: title,
  );
}
