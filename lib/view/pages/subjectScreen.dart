import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:junior_project/data.dart';
import 'package:junior_project/view/pages/lessonPages/lessonScreen.dart';
import 'package:junior_project/view/widget/appBar.dart';
import 'package:junior_project/view/widget/backButton.dart';
import 'package:junior_project/view/widget/container.dart';
import 'package:junior_project/view/widget/listView.dart';
import 'package:junior_project/view/widget/searchBar.dart';

class subjectPage extends StatefulWidget {
  subjectPage({Key key}) : super(key: key);

  @override
  _subjectPage createState() => _subjectPage();
}

class _subjectPage extends State<subjectPage> {
  bool isSearch = false;
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBar(
        leading: backButton(context),
        title:
            isSearch ? searchBar(width, height, searchController) : SizedBox(),
        actions: [
          Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      isSearch = !isSearch;
                    });
                  },
                  icon: Icon(
                    isSearch ? Icons.close : Icons.search,
                    color: Colors.black,
                  )))
        ],
      ),
      body: listView(
          itemCount: 2,
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 2.0,
            );
          },
          itemBuilder: (context, index) {
            return Dismissible(
                key: Key(index.toString()),
                onDismissed: (direction) {
                  if (direction == DismissDirection.endToStart) {}
                },
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  child: Icon(Icons.delete_forever),
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => lessonPage()));
                  },
                  leading: container(
                      width: width * 0.8,
                      color: Colors.transparent,
                      child: AutoSizeText(
                        "الدرس الاول",
                        textDirection: textDirection,
                      )),
                  trailing: Icon(Icons.arrow_forward_ios),
                  focusColor: Colors.blue,
                ));
          }),
    );
  }
}
