import 'package:flutter/material.dart';
import '../app.dart';

/////////////////////////////////////PAGE FOUR////////////////////////////////

class PageFour extends StatefulWidget {
  PageFour({Key key}) : super(key: key);

  @override
  PageFourState createState() => PageFourState();
}

class PageFourState extends State<PageFour> {
  var settingsHeight;
  var settingsWidth;

  Color _background = Color.fromRGBO(240, 243, 250, 1);
  @override
  Widget build(BuildContext context) {
    settingsHeight = MediaQuery.of(context).size.height * 0.2;
    settingsWidth = MediaQuery.of(context).size.width * 0.48;
    return Container(
        height: MediaQuery.of(context).size.height * 1,
        color: _background,
        child: ListView.builder(
          // Let the ListView know how many items it needs to build.
          itemCount: 1,
          padding: EdgeInsets.all(0.0),
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Column(children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[_settingsAbout(), _settingsPassword()],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[_settingsTheme(), _settingsReport()],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _settingsDeleteLocal(),
                    _settingsCredits()
                  ],
                ),
              ]),
            );
          },
        ));
  }

  _settingsAbout() {
    return Container(
        //padding: EdgeInsets.only(top: 3.0, bottom: 5.0),
        height: settingsHeight,
        width: settingsWidth,
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    gradient: new LinearGradient(
                      colors: [entryColor0[0], entryColor0[1]],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      stops: [0.0, 1],
                      tileMode: TileMode.clamp,
                    )),
                child: FlatButton(
                  onPressed: () {
                    print('pressed');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        width: 50.0,
                        height: 50.0,
                        child: Icon(
                          Icons.supervised_user_circle,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                      Center(
                        child: Text('About',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ))));
  }

  _settingsPassword() {
    return Container(
        //padding: EdgeInsets.only(top: 3.0, bottom: 5.0),
        height: settingsHeight,
        width: settingsWidth,
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    gradient: new LinearGradient(
                      colors: [entryColor1[0], entryColor1[1]],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      stops: [0.0, 1],
                      tileMode: TileMode.clamp,
                    )),
                child: FlatButton(
                  onPressed: () {
                    print('pressed');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        width: 50.0,
                        height: 50.0,
                        child: Icon(
                          Icons.lock,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                      Center(
                        child: Text('Set Password',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ))));
  }

  _settingsTheme() {
    return Container(
        //padding: EdgeInsets.only(top: 3.0, bottom: 5.0),
        height: settingsHeight,
        width: settingsWidth,
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    gradient: new LinearGradient(
                      colors: [entryColor2[0], entryColor2[1]],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      stops: [0.0, 1],
                      tileMode: TileMode.clamp,
                    )),
                child: FlatButton(
                  onPressed: () {
                    print('pressed');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        width: 50.0,
                        height: 50.0,
                        child: Icon(
                          Icons.color_lens,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                      Center(
                        child: Text('Theme',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ))));
  }

  _settingsReport() {
    return Container(
        //padding: EdgeInsets.only(top: 3.0, bottom: 5.0),
        height: settingsHeight,
        width: settingsWidth,
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    gradient: new LinearGradient(
                      colors: [entryColor3[0], entryColor3[1]],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      stops: [0.0, 1],
                      tileMode: TileMode.clamp,
                    )),
                child: FlatButton(
                  onPressed: () {
                    print('pressed');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        width: 50.0,
                        height: 50.0,
                        child: Icon(
                          Icons.bug_report,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                      Center(
                        child: Text('Report a Bug',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ))));
  }

  _settingsDeleteLocal() {
    return Container(
        //padding: EdgeInsets.only(top: 3.0, bottom: 5.0),
        height: settingsHeight,
        width: settingsWidth,
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    gradient: new LinearGradient(
                      colors: [entryColor0[0], entryColor0[1]],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      stops: [0.0, 1],
                      tileMode: TileMode.clamp,
                    )),
                child: FlatButton(
                  onPressed: () {
                    print('pressed');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        width: 50.0,
                        height: 50.0,
                        child: Icon(
                          Icons.delete,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                      Center(
                        child: Text('Delete Local Data',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ))));
  }

  _settingsCredits() {
    return Container(
        //padding: EdgeInsets.only(top: 3.0, bottom: 5.0),
        height: settingsHeight,
        width: settingsWidth,
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    gradient: new LinearGradient(
                      colors: [entryColor1[0], entryColor1[1]],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      stops: [0.0, 1],
                      tileMode: TileMode.clamp,
                    )),
                child: FlatButton(
                  onPressed: () {
                    print('pressed');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        width: 50.0,
                        height: 50.0,
                        child: Icon(
                          Icons.info,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                      Center(
                        child: Text('Credits',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ))));
  }
}
