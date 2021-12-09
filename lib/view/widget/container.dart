import 'package:flutter/material.dart';

Widget container({
  double width,
  double height,
  Widget child,
  ImageProvider image = null,
  Color color = Colors.white,
  double radius = 0.0,
  padding = 0.0,
  double opacity = 0.2,
  borderColor = Colors.transparent,
  borderStyle = BorderStyle.none,
  top: 0.0,
  bottom: 0.0,
  left: 0.0,
  right: 0.0,
  topLeftRadius = 0.0,
  topRightRadius = 0.0,
  bottomLeftRadius = 0.0,
  bottomRightRadius = 0.0,
}) {
  return Container(
      width: width,
      height: height,
      child: child,
      padding: EdgeInsets.only(
          top: top != 0.0 ? top : padding,
          bottom: bottom != 0.0 ? bottom : padding,
          left: left != 0.0 ? left : padding,
          right: right != 0.0 ? right : padding),
      decoration: BoxDecoration(
          image: image != null
              ? DecorationImage(
                  fit: BoxFit.fill,
                  image: image,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(opacity), BlendMode.dstATop))
              : null,
          color: color,
          border: Border.all(color: borderColor, style: borderStyle),
          borderRadius: BorderRadius.only(
              topLeft: topLeftRadius == 0.0
                  ? Radius.circular(radius)
                  : Radius.circular(topLeftRadius),
              topRight: topRightRadius == 0.0
                  ? Radius.circular(radius)
                  : Radius.circular(topRightRadius),
              bottomLeft: bottomLeftRadius == 0.0
                  ? Radius.circular(radius)
                  : Radius.circular(bottomLeftRadius),
              bottomRight: bottomRightRadius == 0.0
                  ? Radius.circular(radius)
                  : Radius.circular(bottomRightRadius))));
}
