import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:junior_project/view/widget/appBar.dart';
import 'package:junior_project/view/widget/backButton.dart';
import 'package:junior_project/view/widget/container.dart';

import '../../../data.dart';

class homeWorkPage extends StatefulWidget {
  final int i;
  homeWorkPage(this.i);

  @override
  _homeWorkPage createState() => _homeWorkPage();
}

class _homeWorkPage extends State<homeWorkPage> {
  String txt() {
    if (widget.i == 4) {
      return "النهاية";
    } else {
      return "التالي";
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomSheet: container(
          width: width,
          height: height > 500 ? 80 : height * 0.2,
          color: Colors.blue[400],
          child: FlatButton(
              onPressed: () {
                if (widget.i != 4)
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return homeWorkPage(widget.i + 1);
                  }));
                else {
                  Navigator.of(context).pop();
                }
              },
              child: AutoSizeText(
                txt(),
                textDirection: textDirection,
                style: TextStyle(fontSize: 30.0),
              ))),
      appBar: appBar(leading: backButton(context)),
      body: Padding(
        padding: EdgeInsets.only(
            top: padding,
            right: padding,
            bottom: height > 500 ? 80 : height * 0.2,
            left: padding),
        child: SingleChildScrollView(
          child: container(
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AutoSizeText(
                    "السؤال",
                    textDirection: textDirection,
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  AutoSizeText("", textDirection: textDirection),
                  SizedBox(
                    height: padding,
                  ),
                  AutoSizeText(
                    "الجواب",
                    textDirection: textDirection,
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  CheckboxGroup(labels: ["a", "b", "c", "d", "e", "f"]),
                  SizedBox(height: padding)
                ],
              )),
        ),
      ),
    );
  }
}
