import 'package:flutter/material.dart';
import 'text_section.dart';

class Entry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back, color: Colors.black),
          //   onPressed: () => Navigator.of(context).pop(),
          // ),
          title: new Text(
            "PassVault",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0.0,
          backgroundColor: Colors.white),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextSection('account1', 'user1', 'pass1'),
          ]),
    );
  }
}
