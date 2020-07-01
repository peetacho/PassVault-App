import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/app.dart';

// void main() => runApp(App());

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black, //top bar color
    statusBarIconBrightness: Brightness.dark, //top bar icons
    systemNavigationBarColor: Colors.black, //bottom bar color
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(new MaterialApp(
    home: new MyTextInput(),
  ));
}

class MyTextInput extends StatefulWidget {
  @override
  MyTextInputState createState() => MyTextInputState();
}

class MyTextInputState extends State<MyTextInput> {
  String passVaultPass = "";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text(
            "PassVault",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0.0,
          brightness: Brightness.light,
          backgroundColor: Colors.white),
      body: new Container(
        child: new Center(
            child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new TextField(
              decoration: new InputDecoration(hintText: "Password"),
              onSubmitted: (String str) {
                setState(() {
                  passVaultPass = str;
                  if (passVaultPass == "pass") {
                    runApp(App());
                  }
                });
              },
            ),
            new Text(passVaultPass)
          ],
        )),
      ),
    );
  }
}
