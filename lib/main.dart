import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/app.dart';

// void main() => runApp(App());
Color _background = Color.fromRGBO(240, 243, 250, 1);
void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black, //top bar color
    statusBarIconBrightness: Brightness.dark, //top bar icons
    systemNavigationBarColor: Colors.black, //bottom bar color
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(new MaterialApp(
    theme: ThemeData(
      backgroundColor: _background,
      scaffoldBackgroundColor: _background,
    ),
    debugShowCheckedModeBanner: false,
    home: new PassPage(),
  ));
}

class PassPage extends StatefulWidget {
  @override
  PassPageState createState() => PassPageState();
}

class PassPageState extends State<PassPage> {
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
          ],
        )),
      ),
    );
  }
}
