// app.dart
import 'package:flutter/material.dart';
import 'entry/entry_entry.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  Color _indigo = Color.fromRGBO(98, 122, 239, 1);
  Color _indigo2 = Color.fromRGBO(149, 166, 244, 1);
  Color _indigo_shadow = Color.fromRGBO(206, 214, 244, 0.6);
  Color _background = Color.fromRGBO(240, 243, 250, 1);
  Color _grey = Colors.grey[300];

  Color _normal_icon_1 = Color.fromRGBO(149, 166, 244, 1);
  Color _normal_icon_2 = Colors.grey[300];
  Color _normal_icon_3 = Colors.grey[300];
  Color _normal_icon_4 = Colors.grey[300];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text(
            "PassVault",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0.0,
          backgroundColor: Colors.white),
      body: new Container(
        decoration: BoxDecoration(
          color: _background,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // runApp(Entry());
          debugPrint('add entry button pressed');
        },
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 9.0, color: _indigo),
              shape: BoxShape.circle,
              color: _indigo),
          child: Icon(Icons.add, size: 25.0, color: Colors.white),
        ),
        backgroundColor: _indigo_shadow,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(),
          child: Container(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.home, size: 25.0, color: _normal_icon_1),
                      onPressed: () {
                        setState(() {
                          if (_normal_icon_1 == _grey) {
                            _normal_icon_2 = _grey;
                            _normal_icon_3 = _grey;
                            _normal_icon_4 = _grey;
                            _normal_icon_1 = _indigo2;
                          }
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.apps, size: 25.0, color: _normal_icon_2),
                      onPressed: () {
                        setState(() {
                          if (_normal_icon_2 == _grey) {
                            _normal_icon_1 = _grey;
                            _normal_icon_3 = _grey;
                            _normal_icon_4 = _grey;
                            _normal_icon_2 = _indigo2;
                          }
                        });
                      },
                    ),
                    SizedBox.shrink(),
                    SizedBox.shrink(),
                    SizedBox.shrink(),
                    SizedBox.shrink(),
                    SizedBox.shrink(),
                    SizedBox.shrink(),
                    IconButton(
                      icon: Icon(Icons.satellite,
                          size: 25.0, color: _normal_icon_3),
                      onPressed: () {
                        setState(() {
                          if (_normal_icon_3 == _grey) {
                            _normal_icon_1 = _grey;
                            _normal_icon_2 = _grey;
                            _normal_icon_4 = _grey;
                            _normal_icon_3 = _indigo2;
                          }
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.settings,
                          size: 25.0, color: _normal_icon_4),
                      onPressed: () {
                        setState(() {
                          if (_normal_icon_4 == _grey) {
                            _normal_icon_1 = _grey;
                            _normal_icon_2 = _grey;
                            _normal_icon_3 = _grey;
                            _normal_icon_4 = _indigo2;
                          }
                        });
                      },
                    ),
                  ],
                ),
              ))),
    );
  }
}
