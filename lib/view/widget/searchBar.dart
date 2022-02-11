import 'package:flutter/material.dart';

import '../../data.dart';
import 'container.dart';
import 'textForm.dart';

Widget searchBar(width, height, searchController, onChange) {
  return container(
      width: width * 0.7,
      height: height > 500 ? height * 0.06 : height * 0.1,
      child: textForm(
          isContentPadding: true,
          senderController: searchController,
          textDirection: textDirection,
          onChange: onChange,
          cpv: 0.0,
          cph: 10.0,
          hintText: "ابحث",
          hintDirection: textDirection,
          radius: 10.0));
}
