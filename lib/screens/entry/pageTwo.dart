import 'dart:async';
import 'package:flutter/material.dart';
import '../app.dart';
import 'EntryPage.dart';

/////////////////////////////////////PAGE TWO////////////////////////////////

class PageTwo extends StatefulWidget {
  PageTwo({Key key}) : super(key: key);

  @override
  PageTwoState createState() => PageTwoState();
}

class PageTwoState extends State<PageTwo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return Text('page two');
      },
    );
  }
}
