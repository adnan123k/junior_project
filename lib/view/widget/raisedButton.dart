import 'package:flutter/material.dart';

Widget normalButton(
    {function = null,
    Widget child,
    double padding = 0.0,
    double radius = 0.0,
    Color color = Colors.white,
    elevation = null}) {
  return RaisedButton(
    elevation: elevation,
    onPressed: () {
      if (function != null) {
        function();
      }
    },
    child: child,
    padding: EdgeInsets.all(padding),
    color: color,
    shape: OutlineInputBorder(
        borderSide: BorderSide(style: BorderStyle.none),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(radius),
            bottomRight: Radius.circular(radius))),
  );
}
