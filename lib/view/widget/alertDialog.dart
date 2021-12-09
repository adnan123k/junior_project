import 'package:flutter/material.dart';

Future<void> showAlertDialog(context, {content, action}) {
  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            content: content,
            actions: action,
          );
        });
      });
}
