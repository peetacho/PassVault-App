// app.dart
import 'package:flutter/material.dart';
import 'entry/entry_entry.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new AllEntries(),
    );
  }
}

class AllEntries extends StatefulWidget {
  @override
  AllEntriesState createState() => AllEntriesState();
}

class AllEntriesState extends State<AllEntries> {
  Color _indigo = Color.fromRGBO(98, 122, 239, 1);
  Color _indigo2 = Color.fromRGBO(149, 166, 244, 1);
  Color _indigo_shadow = Color.fromRGBO(206, 214, 244, 0.6);
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
      body: new Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // runApp(Entry());
          debugPrint('pressed');
        },
        elevation: 3,
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
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon:
                          Icon(Icons.home, size: 25.0, color: Colors.grey[300]),
                      onPressed: () {
                        debugPrint('home pressed');
                      },
                    ),
                    IconButton(
                      icon:
                          Icon(Icons.apps, size: 25.0, color: Colors.grey[300]),
                      onPressed: () {
                        debugPrint('apps pressed');
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
                          size: 25.0, color: Colors.grey[300]),
                      onPressed: () {
                        debugPrint('satellite pressed');
                      },
                    ),
                    IconButton(
                      icon:
                          Icon(Icons.home, size: 25.0, color: Colors.grey[300]),
                      onPressed: () {
                        debugPrint('settings');
                      },
                    ),
                  ],
                ),
              ))),
    );
  }
}
