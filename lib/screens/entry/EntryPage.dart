import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pageOne.dart';

Color _searchBarColor = Color.fromRGBO(229, 233, 244, 1);

class EntryPage extends StatelessWidget {
  final item;

  EntryPage(this.item);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text(
              "PassVault",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Edit',
                  style: TextStyle(fontSize: 20.0),
                ),
                textColor: Colors.black,
                onPressed: () {
                  print('edit pressed');
                  print(item);
                },
              )
            ],
            elevation: 0.0,
            backgroundColor: Colors.white),
        body: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  entryItem('Account', item.account),
                  entryItem('Username', item.user),
                  entryItem('Email', item.email),
                  entryItem('Password', item.pass),
                  entryDescriptionItem('Description', item.description),
                ],
              );
            }));
  }

  entryItem(label, item) {
    return Container(
      margin: EdgeInsets.fromLTRB(35.0, 8.0, 35.0, 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
          ),
          TextField(
            readOnly: true,
            decoration: InputDecoration(
                filled: true,
                hintText: item,
                suffixIcon: IconButton(
                    icon: Icon(
                      Icons.content_copy,
                      color: Color.fromRGBO(129, 131, 152, 1),
                    ),
                    onPressed: () {
                      Clipboard.setData(new ClipboardData(text: item));
                    }),
                fillColor: _searchBarColor,
                focusColor: _searchBarColor,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _searchBarColor),
                    borderRadius: BorderRadius.circular(8.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _searchBarColor),
                    borderRadius: BorderRadius.circular(8.0))),
            onChanged: (text) {},
          ),
        ],
      ),
    );
  }

  entryDescriptionItem(label, item) {
    return Container(
      margin: EdgeInsets.fromLTRB(35.0, 8.0, 35.0, 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
          ),
          TextField(
            readOnly: true,
            maxLines: 7,
            decoration: InputDecoration(
                // contentPadding: const EdgeInsets.symmetric(vertical: 60.0),
                filled: true,
                hintText: item,
                suffixIcon: IconButton(
                    icon: Icon(
                      Icons.content_copy,
                      color: Color.fromRGBO(129, 131, 152, 1),
                    ),
                    onPressed: () {
                      print(item);
                    }),
                fillColor: _searchBarColor,
                focusColor: _searchBarColor,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _searchBarColor),
                    borderRadius: BorderRadius.circular(8.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _searchBarColor),
                    borderRadius: BorderRadius.circular(8.0))),
            onChanged: (text) {},
          ),
        ],
      ),
    );
  }
}
