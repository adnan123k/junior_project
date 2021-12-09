import 'package:flutter/material.dart';

Widget listView(
    {itemCount = 0, separatorBuilder, itemBuilder, physcis = null}) {
  return ListView.separated(
      itemCount: itemCount,
      physics: physcis,
      separatorBuilder: separatorBuilder,
      itemBuilder: itemBuilder);
}
