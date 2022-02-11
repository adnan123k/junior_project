import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import './textForm.dart';

import '../../data.dart';
import 'container.dart';

Widget labelAndTextForm(height, width, label,
    {keyboardType = TextInputType.text,
    textDirection = textDirection,
    String value = "",
    textController,
    validation}) {
  return container(
      width: width,
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          container(
              width: width * 0.7,
              child: value == ""
                  ? textForm(
                      type: keyboardType,
                      radius: textFieldRadius,
                      isContentPadding: true,
                      cph: padding,
                      senderController: textController,
                      validateFunction: validation,
                      textDirection: textDirection)
                  : AutoSizeText(
                      value,
                      textDirection: textDirection,
                      style: TextStyle(fontSize: height * 0.05),
                    )),
          SizedBox(
            width: padding,
          ),
          container(
              height: height * 0.06,
              width: value == "" ? width * 0.1 : width * 0.2,
              child: AutoSizeText(
                label,
                textDirection: TextDirection.rtl,
              ))
        ],
      ));
}
