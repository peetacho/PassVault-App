// app.dart
import 'entry/entry_entry.dart';
import 'package:flutter/material.dart';

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
  }

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
      body: new Container(
        decoration: BoxDecoration(
          color: _background,
        ),
        child: PageStorage(child: currentPage, bucket: bucket),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // runApp(Entry());
          debugPrint('add entry button pressed');
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
}

class PageOne extends StatefulWidget {
  PageOne({Key key}) : super(key: key);

  @override
  PageOneState createState() => PageOneState();
}

class PageOneState extends State<PageOne> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 250.0,
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.all(8.0),
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(5.0),
          color: index % 2 == 0 ? Colors.green : Colors.yellow,
          child: Center(
            child: Text(index.toString()),
          ),
        ),
      ),
    );
  }
}

class PageTwo extends StatefulWidget {
  PageTwo({Key key}) : super(key: key);

  @override
  PageTwoState createState() => PageTwoState();
}

class PageTwoState extends State<PageTwo> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 250.0,
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.all(8.0),
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(5.0),
          color: index % 2 == 0 ? Colors.cyan : Colors.deepOrange,
          child: Center(
            child: Text(index.toString()),
          ),
        ),
      ),
    );
  }
}

class PageThree extends StatefulWidget {
  PageThree({Key key}) : super(key: key);

  @override
  PageThreeState createState() => PageThreeState();
}

class PageThreeState extends State<PageThree> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 250.0,
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.all(8.0),
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(5.0),
          color: index % 2 == 0 ? Colors.pink : Colors.white,
          child: Center(
            child: Text(index.toString()),
          ),
        ),
      ),
    );
  }
}

class PageFour extends StatefulWidget {
  PageFour({Key key}) : super(key: key);

  @override
  PageFourState createState() => PageFourState();
}

class PageFourState extends State<PageFour> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 250.0,
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.all(8.0),
        child: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(5.0),
          color: index % 2 == 0 ? Colors.yellow : Colors.purple,
          child: Center(
            child: Text(index.toString()),
          ),
        ),
      ),
    );
  }
}
