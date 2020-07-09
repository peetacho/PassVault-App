import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Color _background = Color.fromRGBO(240, 243, 250, 1);

class SettingOption extends StatefulWidget {
  final String option;

  SettingOption(this.option);

  @override
  SettingOptionState createState() => SettingOptionState(option);
}

class SettingOptionState extends State<SettingOption> {
  final option;
  SettingOptionState(this.option);

  @override
  void initState() {
    super.initState();
  }

  _getSetting(option) {
    switch (option) {
      case 'About':
        return _settingsAbout();
        break;
      case 'Set Password':
        return _settingsPass();
        break;
      case 'Share':
        return Text(option);
        break;
      case 'Report a Bug':
        return Text(option);
        break;
      case 'Delete Local Data':
        return Text(option);
        break;
      case 'Credits':
        return _settingsCredits();
        break;
    }
  }

  void _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _settingsAbout() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[Text('Version'), Text('1.0.1')],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                iconSize: 45.0,
                icon: Tab(
                  icon: Image.asset('assets/github.png'),
                ),
                onPressed: () {
                  _launchURL('https://github.com/peetacho');
                },
              ),
              IconButton(
                iconSize: 45.0,
                icon: Tab(
                  icon: Image.asset('assets/linkedin.png'),
                ),
                onPressed: () {
                  _launchURL(
                      'https://www.linkedin.com/in/peter-chow-07505b1b0/');
                },
              ),
              IconButton(
                iconSize: 45.0,
                icon: Tab(
                  icon: Image.asset('assets/gmail.png'),
                ),
                onPressed: () {
                  _launchURL('mailto:peterworks2001@gmail.com');
                },
              ),
            ],
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.all(18.0),
            child: Text('Copyright \u00a9 ' +
                DateTime.now().year.toString() +
                ', Peter Chow'),
          ),
        ],
      ),
    );
  }

  _settingsPass() {}

  _settingsCredits() {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Spacer(),
          Wrap(
            // mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: <Widget>[
              Image.asset(
                'assets/facebook.png',
                height: 40,
                width: 40,
              ),
              Image.asset(
                'assets/instagram.png',
                height: 40,
                width: 40,
              ),
              Image.asset(
                'assets/skype.png',
                height: 40,
                width: 40,
              ),
              Image.asset(
                'assets/reddit.png',
                height: 40,
                width: 40,
              ),
              Text(
                '...',
                style: TextStyle(fontSize: 40),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
              'Icons made by Pixel perfect, Freepix, and alicia_mb from www.flaticon.com'),
          Spacer(),
          Container(
            margin: EdgeInsets.all(18.0),
            child: Text('Copyright \u00a9 ' +
                DateTime.now().year.toString() +
                ', Peter Chow'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: _background,
      appBar: new AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () {
                Navigator.pop(context);
              }),
          brightness: Brightness.light,
          elevation: 0.0,
          backgroundColor: Colors.white),
      body: _getSetting(option),
    );
  }
}
