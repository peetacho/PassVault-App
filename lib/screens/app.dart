// app.dart
import 'entry/EntryPage.dart';
import 'entry/pageOne.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// COLORS //
Color _indigo = Color.fromRGBO(98, 122, 239, 1);
Color _indigo2 = Color.fromRGBO(149, 166, 244, 1);
Color _indigoShadow = Color.fromRGBO(206, 214, 244, 0.6);
Color _background = Color.fromRGBO(240, 243, 250, 1);
Color _searchBarColor = Color.fromRGBO(229, 233, 244, 1);
Color _grey = Colors.grey[300];

// ICON COLORS //
Color _normalIcon1 = Color.fromRGBO(149, 166, 244, 1);
Color _normalIcon2 = Colors.grey[300];
Color _normalIcon3 = Colors.grey[300];
Color _normalIcon4 = Colors.grey[300];

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Home(),
    );
  }
}

class JSONStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File("$path/jsonStorage.txt");
  }

  Future<String> readJSONStorage() async {
    try {
      final file = await _localFile;
      String contents = await file.readAsString();
      // debugPrint("reading readJSONStorage file stuff: " + contents);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('jsonFileString', contents);
      return contents;
    } catch (err) {
      return "";
    }
  }

  Future<File> writeJSONStorage(String str) async {
    final file = await _localFile;
    readJSONStorage();
    return file.writeAsString(str);
  }
}

class Home extends StatefulWidget {
  //instantiates jsonstorage class
  final JSONStorage jsonStorage = JSONStorage();
  @override
  HomeState createState() => HomeState();
}

final PageStorageBucket bucket = PageStorageBucket();

class HomeState extends State<Home> {
  final Key keyOne = PageStorageKey('pageOne');
  final Key keyTwo = PageStorageKey('pageTwo');
  final Key keyThree = PageStorageKey('pageThree');
  final Key keyFour = PageStorageKey('pageFour');

  PageOne _pageOne;
  PageTwo _pageTwo;
  PageThree _pageThree;
  PageFour _pageFour;
  List<Widget> pages;
  Widget currentPage;

  String readToString;
  @override
  void initState() {
    // sets keys for different pages
    _pageOne = PageOne(
      key: keyOne,
    );
    _pageTwo = PageTwo(
      key: keyTwo,
    );
    _pageThree = PageThree(
      key: keyThree,
    );
    _pageFour = PageFour(
      key: keyFour,
    );
    //getJsonFileString();

    // for storage
    pages = [_pageOne, _pageTwo, _pageThree, _pageFour];
    currentPage = _pageOne;

    widget.jsonStorage.readJSONStorage().then((String result) => setState(() {
          readToString = result;
        }));

    super.initState();

    // for refresh page
    refreshList();
  }

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));
    getJsonFileString();
    setState(() {
      (context as Element).reassemble();
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: PreferredSize(
          child: AppBar(
              title: new Text(
                "PassVault",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              elevation: 0.0,
              brightness: Brightness.light,
              backgroundColor: Colors.white),
          preferredSize: Size.fromHeight(60.0)),
      body: RefreshIndicator(
        backgroundColor: _background,
        color: _indigo,
        child: PageStorage(child: currentPage, bucket: bucket),
        onRefresh: refreshList,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _tripEditModalBottomSheet(context);
        },
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 9.0, color: _indigo),
              shape: BoxShape.circle,
              color: _indigo),
          child: Icon(Icons.add, size: 25.0, color: Colors.white),
        ),
        backgroundColor: _indigoShadow,
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
                      icon: Icon(Icons.home, size: 25.0, color: _normalIcon1),
                      onPressed: () {
                        setState(() {
                          if (_normalIcon1 == _grey) {
                            _normalIcon2 = _grey;
                            _normalIcon3 = _grey;
                            _normalIcon4 = _grey;
                            _normalIcon1 = _indigo2;
                            currentPage = pages[0];
                          }
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.stars, size: 25.0, color: _normalIcon2),
                      onPressed: () {
                        setState(() {
                          if (_normalIcon2 == _grey) {
                            _normalIcon1 = _grey;
                            _normalIcon3 = _grey;
                            _normalIcon4 = _grey;
                            _normalIcon2 = _indigo2;
                            currentPage = pages[1];
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
                      icon:
                          Icon(Icons.security, size: 25.0, color: _normalIcon3),
                      onPressed: () {
                        setState(() {
                          if (_normalIcon3 == _grey) {
                            _normalIcon1 = _grey;
                            _normalIcon2 = _grey;
                            _normalIcon4 = _grey;
                            _normalIcon3 = _indigo2;
                            currentPage = pages[2];
                          }
                        });
                      },
                    ),
                    IconButton(
                      icon:
                          Icon(Icons.settings, size: 25.0, color: _normalIcon4),
                      onPressed: () {
                        setState(() {
                          if (_normalIcon4 == _grey) {
                            _normalIcon1 = _grey;
                            _normalIcon2 = _grey;
                            _normalIcon3 = _grey;
                            _normalIcon4 = _indigo2;
                            currentPage = pages[3];
                          }
                        });
                      },
                    ),
                  ],
                ),
              ))),
    );
  }

  ////////////////////////////// Entry Page ///////////////////////////

  final formKey = GlobalKey<FormState>();
  String _addedAccount,
      _addedEmail,
      _addedUsername,
      _addedPassword,
      _addedDescription;

  void _tripEditModalBottomSheet(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.white,
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(''),
                        Spacer(),
                        IconButton(
                            icon: Icon(Icons.close, size: 25),
                            onPressed: () => Navigator.of(context).pop()),
                      ],
                    ),
                    Container(
                      child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              entryAccountItem('Account'),
                              entryUserItem('Username'),
                              entryEmailItem('Email'),
                              entryPassItem('Password'),
                              entryDescItem('Description'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: RaisedButton(
                                      onPressed: () {
                                        _submit();
                                      },
                                      child: Text('Add Entry'),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                  ],
                )),
          );
        });
  }

  entryAccountItem(label) {
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
          TextFormField(
            validator: (input) =>
                input.length < 1 ? 'Please input an account' : null,
            onSaved: (input) => _addedAccount = input,
            readOnly: false,
            decoration: InputDecoration(
                filled: true,
                fillColor: _searchBarColor,
                focusColor: _searchBarColor,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _searchBarColor),
                    borderRadius: BorderRadius.circular(8.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _searchBarColor),
                    borderRadius: BorderRadius.circular(8.0))),
          ),
        ],
      ),
    );
  }

  entryUserItem(label) {
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
          TextFormField(
            validator: (input) =>
                input.length < 0 ? 'Please input something' : null,
            onSaved: (input) => _addedUsername = input,
            readOnly: false,
            decoration: InputDecoration(
                filled: true,
                fillColor: _searchBarColor,
                focusColor: _searchBarColor,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _searchBarColor),
                    borderRadius: BorderRadius.circular(8.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _searchBarColor),
                    borderRadius: BorderRadius.circular(8.0))),
          ),
        ],
      ),
    );
  }

  entryEmailItem(label) {
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
          TextFormField(
            validator: (input) =>
                input.length < 0 ? 'Please input something' : null,
            onSaved: (input) => _addedEmail = input,
            readOnly: false,
            decoration: InputDecoration(
                filled: true,
                fillColor: _searchBarColor,
                focusColor: _searchBarColor,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _searchBarColor),
                    borderRadius: BorderRadius.circular(8.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _searchBarColor),
                    borderRadius: BorderRadius.circular(8.0))),
          ),
        ],
      ),
    );
  }

  bool _isHidden2 = true;

  var _visb2 = Icons.visibility_off;

  void _toggleVisibility() {
    setState(() {
      _isHidden2 = !_isHidden2;
      if (_visb2 == Icons.visibility_off) {
        _visb2 = Icons.visibility;
      } else {
        _visb2 = Icons.visibility_off;
      }
    });
  }

  entryPassItem(label) {
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
          TextFormField(
            obscureText: _isHidden2,
            validator: (input) =>
                input.length < 1 ? 'Please input a password' : null,
            onSaved: (input) => _addedPassword = input,
            readOnly: false,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    icon: Icon(
                      _visb2,
                      color: Color.fromRGBO(129, 131, 152, 1),
                    ),
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: () {
                      _toggleVisibility();
                    }),
                filled: true,
                fillColor: _searchBarColor,
                focusColor: _searchBarColor,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _searchBarColor),
                    borderRadius: BorderRadius.circular(8.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _searchBarColor),
                    borderRadius: BorderRadius.circular(8.0))),
          ),
        ],
      ),
    );
  }

  entryDescItem(label) {
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
          TextFormField(
            validator: (input) =>
                input.length < 0 ? 'Please input something' : null,
            onSaved: (input) => _addedDescription = input,
            readOnly: false,
            maxLines: 5,
            decoration: InputDecoration(
                filled: true,
                fillColor: _searchBarColor,
                focusColor: _searchBarColor,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _searchBarColor),
                    borderRadius: BorderRadius.circular(8.0)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: _searchBarColor),
                    borderRadius: BorderRadius.circular(8.0))),
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (formKey.currentState.validate()) {
      //save form inputs
      formKey.currentState.save();
      var id = new DateTime.now().millisecondsSinceEpoch;

      //append entry item into items list
      items.insert(
          0,
          EntryItem(_addedAccount, _addedEmail, _addedUsername, _addedPassword,
              _addedDescription, id));

      debugPrint('UID : ' + id.toString());
      //EntryItem objects converted to JSON string
      itemsToJSON = jsonEncode(items);

      widget.jsonStorage.writeJSONStorage(itemsToJSON);

      formKey.currentState.reset();
    }
  }
}

var jsonFileString;

getJsonFileString() async {
  final prefs = await SharedPreferences.getInstance();
  jsonFileString = prefs.getString('jsonFileString');
  if (jsonFileString != null) {
    // debugPrint(jsonFileString);
    // JSON String converted to EntryItem objects
    var decodedItemsToJSON = jsonDecode(jsonFileString) as List;
    List<ListItem> newItems = decodedItemsToJSON
        .map((tagJson) => EntryItem.fromJson(tagJson))
        .toList();

    items = newItems;
    itemsDisplay = newItems;
  }
}

List<ListItem> items = [];
List<ListItem> itemsDisplay = [];

String itemsToJSON;

/// The base class for the different types of items the list can contain.
abstract class ListItem {
  Widget buildAccount(BuildContext context);

  /// The title line to show in a list item.
  Widget buildUser(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildIndex(BuildContext context);
}

/// A ListItem that contains data to display a message.
class EntryItem implements ListItem {
  final String account;
  final String email;
  final String user;
  final String pass;
  final String description;
  final int index;

  EntryItem(this.account, this.email, this.user, this.pass, this.description,
      this.index);

  factory EntryItem.fromJson(dynamic json) {
    return EntryItem(
      json['account'] as String,
      json['email'] as String,
      json['user'] as String,
      json['pass'] as String,
      json['description'] as String,
      json['index'] as int,
    );
  }

  Map toJson() => {
        'account': account,
        'email': email,
        'user': user,
        'pass': pass,
        'description': description,
        'index': index,
      };

  Widget buildAccount(BuildContext context) {
    return Text(
      account,
      style: TextStyle(
          fontSize: 19, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  String userOrEmail() {
    if (user == '' && email == '') {
      return 'N/A';
    } else {
      if (user == '' || user == null) {
        return 'Email: ' + email;
      } else {
        return 'Username: ' + user;
      }
    }
  }

  String newPass() {
    String newPass = '';
    for (var i = 0; i < pass.length; i++) {
      newPass += '•';
    }
    return newPass;
  }

  Widget buildUser(BuildContext context) {
    return Container(
        child: Text(userOrEmail() + "\n" + "Password: " + newPass() + "\n",
            style: TextStyle(color: Colors.white, fontSize: 13)));
  }

  Widget buildIndex(BuildContext context) => Text('$index');

  @override
  String toString() {
    return '{${this.account}, ${this.email}, ${this.user}, ${this.pass}, ${this.description}}, ${this.index}';
  }
}

var entryColor = [];

var entryColor0 = [
  Color.fromRGBO(129, 158, 241, 1),
  Color.fromRGBO(163, 185, 245, 1)
];

var entryColor1 = [
  Color.fromRGBO(126, 129, 185, 1),
  Color.fromRGBO(168, 171, 211, 1)
];

var entryColor2 = [
  Color.fromRGBO(238, 140, 149, 1),
  Color.fromRGBO(243, 179, 182, 1)
];

var entryColor3 = [
  Color.fromRGBO(62, 65, 144, 1),
  Color.fromRGBO(125, 126, 184, 1)
];

/////////////////////////////////////PAGE TWO////////////////////////////////

class PageTwo extends StatefulWidget {
  PageTwo({Key key}) : super(key: key);

  @override
  PageTwoState createState() => PageTwoState();
}

class PageTwoState extends State<PageTwo> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 7,
      itemBuilder: (context, index) {
        return Text('nice');
      },
    );
  }
}

/////////////////////////////////////PAGE THREE////////////////////////////////

class PageThree extends StatefulWidget {
  PageThree({Key key}) : super(key: key);

  @override
  PageThreeState createState() => PageThreeState();
}

class PageThreeState extends State<PageThree> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 7,
        itemBuilder: (BuildContext ctxt, int index) {
          return Text('nice');
        });
  }
}

/////////////////////////////////////PAGE FOUR////////////////////////////////

class PageFour extends StatefulWidget {
  PageFour({Key key}) : super(key: key);

  @override
  PageFourState createState() => PageFourState();
}

class PageFourState extends State<PageFour> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 7,
        itemBuilder: (BuildContext ctxt, int index) {
          return Text('nice');
        });
  }
}
