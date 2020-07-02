// app.dart
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

// COLORS //
Color _indigo = Color.fromRGBO(98, 122, 239, 1);
Color _indigo2 = Color.fromRGBO(149, 166, 244, 1);
Color _indigoShadow = Color.fromRGBO(206, 214, 244, 0.6);
Color _background = Color.fromRGBO(240, 243, 250, 1);
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

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

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

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
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

    pages = [_pageOne, _pageTwo, _pageThree, _pageFour];
    currentPage = _pageOne;
    super.initState();
    refreshList();
  }

  var refreshKey = GlobalKey<RefreshIndicatorState>();

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));

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
        // decoration: BoxDecoration(
        //   color: _background,
        // ),
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
                        Text("Text"),
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
                              TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Account:'),
                                  validator: (input) => input.length < 1
                                      ? 'Please input an account'
                                      : null,
                                  onSaved: (input) => _addedAccount = input),
                              TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Email:'),
                                  validator: (input) => input.length < 0
                                      ? 'Please input a valid email'
                                      : null,
                                  onSaved: (input) => _addedEmail = input),
                              TextFormField(
                                  decoration:
                                      InputDecoration(labelText: 'Username:'),
                                  validator: (input) => input.length < 0
                                      ? 'Please input an username'
                                      : null,
                                  onSaved: (input) => _addedUsername = input),
                              TextFormField(
                                decoration:
                                    InputDecoration(labelText: 'Password:'),
                                validator: (input) => input.length < 1
                                    ? 'Please input a password'
                                    : null,
                                onSaved: (input) => _addedPassword = input,
                                obscureText: true,
                              ),
                              TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'Description:'),
                                  validator: (input) => input.length < 0
                                      ? 'Please input an description'
                                      : null,
                                  onSaved: (input) =>
                                      _addedDescription = input),
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

  void _submit() {
    if (formKey.currentState.validate()) {
      //save form inputs
      formKey.currentState.save();

      //append entry item into items list
      items.add(EntryItem(_addedAccount, _addedEmail, _addedUsername,
          _addedPassword, _addedDescription));

      //EntryItem objects converted to JSON string
      itemsToJSON = jsonEncode(items);

      print(itemsToJSON);
      formKey.currentState.reset();
    }
  }
}

List<ListItem> items = [];

String itemsToJSON;

// var jsonItems = [
//   {"account": "Account1", "user": "user1", "pass": "pass1"},
//   {"account": "Account2", "user": "user2", "pass": "pass2"},
//   {"account": "Account3", "user": "user3", "pass": "pass3"},
//   {"account": "Account4", "user": "user4", "pass": "pass4"},
//   {"account": "Account5", "user": "user5", "pass": "pass5"},
//   {"account": "Account6", "user": "user6", "pass": "pass6"},
//   {"account": "Account7", "user": "user7", "pass": "pass7"},
//   {"account": "Account8", "user": "user8", "pass": "pass8"},
//   {"account": "Account9", "user": "user9", "pass": "pass9"},
//   {"account": "Account10", "user": "user10", "pass": "pass10"}
// ];

// List<ListItem> jSONToItems;

List<String> testItem = ['asdad', 'niwferce', 'wefwefe', 'asdasdwefwefe'];

/// The base class for the different types of items the list can contain.
abstract class ListItem {
  Widget buildAccount(BuildContext context);

  /// The title line to show in a list item.
  Widget buildUser(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  Widget buildPass(BuildContext context);
}

/// A ListItem that contains data to display a message.
class EntryItem implements ListItem {
  final String account;
  final String email;
  final String user;
  final String pass;
  final String description;

  EntryItem(this.account, this.email, this.user, this.pass, this.description);

  factory EntryItem.fromJson(dynamic json) {
    return EntryItem(
        json['account'] as String,
        json['email'] as String,
        json['user'] as String,
        json['pass'] as String,
        json['description'] as String);
  }

  Map toJson() => {
        'account': account,
        'email': email,
        'user': user,
        'pass': pass,
        'description': description,
      };

  Widget buildAccount(BuildContext context) {
    return Text(
      account,
      style: TextStyle(
          fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
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

  Widget buildUser(BuildContext context) {
    return Container(
      child: Text(
        userOrEmail() + "\n" + "Password: " + pass + "\n",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget buildPass(BuildContext context) => Text(pass);

  @override
  String toString() {
    return '{${this.account}, ${this.email}, ${this.user}, ${this.pass}, ${this.description}}';
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

/////////////////////////////////////PAGE ONE////////////////////////////////
class PageOne extends StatefulWidget {
  PageOne({Key key}) : super(key: key);

  @override
  PageOneState createState() => PageOneState();
}

class PageOneState extends State<PageOne> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Let the ListView know how many items it needs to build.
      itemCount: items.length,
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index) {
        final item = items[index];

        int colorIndex = index % 4;

        switch (colorIndex) {
          case 0:
            entryColor = entryColor0;
            break;
          case 1:
            entryColor = entryColor1;
            break;
          case 2:
            entryColor = entryColor2;
            break;
          case 3:
            entryColor = entryColor3;
            break;
        }

        return Container(
            margin: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
            ),
            height: 120.0,
            child: Container(
                padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
                child: GradientCard(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ListTile(
                            leading: Icon(
                              Icons.star_half,
                              color: Colors.white,
                              size: 45,
                            ),
                            title: item.buildAccount(context),
                            subtitle: item.buildUser(context),
                            trailing: IconButton(
                                icon:
                                    Icon(Icons.more_vert, color: Colors.white),
                                onPressed: () {
                                  debugPrint('more vert card ${index + 1}');
                                }),
                            isThreeLine: true,
                            onTap: () {
                              debugPrint('card ${index + 1}');
                              print(item);
                            },
                          ),
                        ]),
                    elevation: 4.0,
                    gradient: new LinearGradient(
                      colors: [entryColor[0], entryColor[1]],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      stops: [0.0, 1],
                      tileMode: TileMode.clamp,
                    ))));
      },
    );
  }
}

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
      itemCount: items.length,
      itemBuilder: (context, index) {
        Text('nice');
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
        itemCount: testItem.length,
        itemBuilder: (BuildContext ctxt, int index) {
          Text('nice');
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
        itemCount: testItem.length,
        itemBuilder: (BuildContext ctxt, int index) {
          Text('nice');
        });
  }
}
