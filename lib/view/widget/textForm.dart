import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget textForm({
  TextEditingController senderController = null,
  submitFunction = null,
  validateFunction = null,
  double radius = 0.0,
  Color color = Colors.white,
  bool isContentPadding = false,
  double cph = 0.0,
  double cpv = 0.0,
  String hintText = null,
  bool isLimit = false,
  int maxNumber,
  Color cursorColor = Colors.black,
  TextInputType type = TextInputType.text,
  bool isPassword = false,
  hintDirection = null,
  onChange = null,
  textDirection = TextDirection.ltr,
  int maxLines = 1,
  style = null,
  hintStyle = null,
  focusNode = null,
}) {
  return TextFormField(
    keyboardType: type,
    focusNode: focusNode,
    textDirection: textDirection,
    obscureText: isPassword,
    maxLines: maxLines,
    inputFormatters: !isLimit
        ? null
        : [
            new LengthLimitingTextInputFormatter(maxNumber),
          ],
    cursorColor: cursorColor,
    style: style,
    controller: senderController,
    onChanged: (_) {
      if (onChange != null) {
        onChange();
      }
    },
    validator: (value) {
      if (validateFunction != null) {
        validateFunction(value);
      }
    },
    onFieldSubmitted: (value) {
      if (submitFunction != null) {
        submitFunction(value);
      }
    },
    decoration: InputDecoration(
        hintText: hintText,
        hintTextDirection :hintDirection,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(radius))),
        contentPadding: isContentPadding
            ? EdgeInsets.symmetric(horizontal: cph, vertical: cpv)
            : null,
        fillColor: color,
        filled: true,
        border: OutlineInputBorder(
            borderSide: BorderSide(style: BorderStyle.none),
            borderRadius: BorderRadius.all(Radius.circular(radius)))),
  );
}
