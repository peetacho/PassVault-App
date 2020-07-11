import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/app.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// void main() => runApp(App());
Color _background = Color.fromRGBO(240, 243, 250, 1);
void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black, //top bar color
    statusBarIconBrightness: Brightness.dark, //top bar icons
    systemNavigationBarColor: Colors.black, //bottom bar color
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(new MaterialApp(
    theme: ThemeData(
      backgroundColor: _background,
      scaffoldBackgroundColor: _background,
    ),
    debugShowCheckedModeBanner: false,
    home: new PassPage(),
  ));
}

class PassPage extends StatefulWidget {
  @override
  PassPageState createState() => PassPageState();
}

class PassPageState extends State<PassPage> {
  final _storage = FlutterSecureStorage();
  String passVaultPass = "";
  bool hasPass = false;

  void _getPass() async {
    final pvPass = await _storage.read(key: 'passVaultPass');
    final hasPassBoolString = await _storage.read(key: 'hasPass');

    if (hasPassBoolString != null) {
      setState(() {
        passVaultPass = pvPass;
        hasPass = hasPassBoolString == 'true';
      });
    }
  }

  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });

    if (authenticated) {
      _toApp();
    }
  }

  void _cancelAuthentication() {
    auth.stopAuthentication();
  }

  @override
  void initState() {
    _checkBiometrics();
    _getAvailableBiometrics();
    _getPass();
    super.initState();
  }

  _toApp() {
    Navigator.pushReplacement(
      context,
      new PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => new App(),
        transitionsBuilder: (context, animation1, animation2, child) {
          return SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(1.0, 0.0), end: Offset.zero)
                      .animate(animation1),
              child: SlideTransition(
                position: Tween<Offset>(
                        begin: Offset.zero, end: const Offset(1.0, 0.0))
                    .animate(animation2),
                child: child,
              ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text(
            "PassVault",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0.0,
          brightness: Brightness.light,
          backgroundColor: Colors.white),
      body: new Container(
        child: new Center(
            child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _logo(),
            _hasPass(),
            Text(passVaultPass + "    " + hasPass.toString()),
          ],
        )),
      ),
    );
  }

  _logo() {
    return Container(
        margin: EdgeInsets.only(bottom: 15),
        width: 100.0,
        height: 100.0,
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            shape: BoxShape.rectangle,
            image: new DecorationImage(
                image: AssetImage('assets/passvault.png'))));
  }

  _hasPass() {
    if (hasPass) {
      return Column(
        children: <Widget>[
          Text('Current State: $_authorized\n'),
          RaisedButton(
            child: Text(_isAuthenticating ? 'Cancel' : 'Authenticate'),
            onPressed:
                _isAuthenticating ? _cancelAuthentication : _authenticate,
          ),
          TextField(
            decoration: new InputDecoration(hintText: "Password"),
            onSubmitted: (String str) {
              if (passVaultPass == str) {
                _toApp();
              }
            },
          ),
        ],
      );
    } else {
      return RaisedButton(
        child: Text('welcome'),
        onPressed: () {
          runApp(App());
        },
      );
    }
  }
}
