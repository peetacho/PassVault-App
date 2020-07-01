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
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline),
              title: Text('Add'),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
              backgroundColor: Colors.black),
        ],
      ),
    );
  }
}
