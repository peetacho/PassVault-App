import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

Color _background = Color.fromRGBO(240, 243, 250, 1);
Color _searchBarColor = Color.fromRGBO(229, 233, 244, 1);

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
      case 'Report a Bug':
        return _settingsBug();
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

  final _storage = FlutterSecureStorage();
  final formKeyPass = GlobalKey<FormState>();

  String _passVaultPass;

  void _setPass() async {
    if (formKeyPass.currentState.validate()) {
      formKeyPass.currentState.save();

      await _storage.write(key: 'passVaultPass', value: _passVaultPass);
      await _storage.write(key: 'hasPass', value: 'true');
      // debugPrint(_passVaultPass);

      formKeyPass.currentState.reset();
    }
  }

  _settingsPass() {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Form(
                key: formKeyPass,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    inputPassVaultPass(),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: SizedBox(
                      height: 55,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: FlatButton(
                          color: Colors.green[400], //entryColor2[0],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Text(
                              'Set password',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            _setPass();
                          }),
                    )),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  inputPassVaultPass() {
    return Container(
      margin: EdgeInsets.only(top: 8.0, right: 8.0),
      width: MediaQuery.of(context).size.width * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: Text(
              'New Password',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
          ),
          TextFormField(
            validator: (input) =>
                input.length < 1 ? 'Please enter a password.' : null,
            onSaved: (input) => _passVaultPass = input,
            readOnly: false,
            decoration: InputDecoration(
                filled: true,
                fillColor: _searchBarColor,
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

  final formKey = GlobalKey<FormState>();
  String _userSubject, _userBody;

  _settingsBug() {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Container(
            child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _emailSubject(),
                    _emailBody(),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: SizedBox(
                      height: 55,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: FlatButton(
                          color: Colors.green[400], //entryColor2[0],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Center(
                            child: Text(
                              'Send Bug Report',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            send();
                            //send();
                          }),
                    )),
                  ],
                )),
          ),
        ],
      ),
    );
  }

  _emailSubject() {
    return Container(
      margin: EdgeInsets.only(top: 8.0, right: 8.0),
      width: MediaQuery.of(context).size.width * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: Text(
              'Subject',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
          ),
          TextFormField(
            validator: (input) =>
                input.length < 1 ? 'Please enter a subject.' : null,
            onSaved: (input) => _userSubject = input,
            readOnly: false,
            decoration: InputDecoration(
                filled: true,
                fillColor: _searchBarColor,
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

  _emailBody() {
    return Container(
      margin: EdgeInsets.only(top: 8.0, right: 8.0),
      width: MediaQuery.of(context).size.width * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: Text(
              'Message',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
          ),
          TextFormField(
            validator: (input) =>
                input.length < 1 ? 'Please enter a message' : null,
            onSaved: (input) => _userBody = input,
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

  Future<void> send() async {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      final Email email = Email(
        body: _userBody,
        subject: '[PV BUG REPORT:] ' + _userSubject,
        recipients: ['peterworks2001@gmail.com'],
        // attachmentPath: attachment,
      );

      String platformResponse;

      try {
        await FlutterEmailSender.send(email);
        platformResponse = 'success';
      } catch (error) {
        platformResponse = error.toString();
      }

      if (!mounted) return;

      debugPrint(platformResponse);
      print(email.body + email.subject + email.recipients[0]);

      formKey.currentState.reset();
    }
  }

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
