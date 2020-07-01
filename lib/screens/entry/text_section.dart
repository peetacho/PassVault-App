import 'package:flutter/material.dart';

class TextSection extends StatelessWidget {
  final String accountTitle;
  final String username;
  final String password;

  TextSection(this.accountTitle, this.username, this.password);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(accountTitle + username + password),
    );
  }
}
