import 'package:flutter/material.dart';

Widget dropDownButton(
    {function = null, initValue = "", List<DropdownMenuItem> list}) {
  return DropdownButton(
      isExpanded: true,
      underline: SizedBox(),
      onChanged: function,
      value: initValue,
      items: list);
}
