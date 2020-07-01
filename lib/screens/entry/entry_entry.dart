import 'package:flutter/material.dart';
import 'text_section.dart';

class Entry extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextSection('account1', 'user1', 'pass1'),
            TextSection('account2', 'user2', 'pass2'),
          ]),
    );
  }
}
