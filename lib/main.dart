import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/app.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_admob/firebase_admob.dart';

// void main() => runApp(App());
Color _background = Color.fromRGBO(240, 243, 250, 1);
Color _searchBarColor = Color.fromRGBO(229, 233, 244, 0.4);

// AD //
const String testDevice = '';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black, //top bar color
    statusBarIconBrightness: Brightness.dark, //top bar icons
    systemNavigationBarColor: Colors.black, //bottom bar color
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(new MaterialApp(
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
  String _userInputPass = "";

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

    print(hasPass);
    if (!hasPass) {
      nextApp();
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

  Future<void> nextApp() async {
    await new Future.delayed(const Duration(seconds: 3));
    _toApp();
  }

  void _cancelAuthentication() {
    auth.stopAuthentication();
  }

  // ADS
  static final MobileAdTargetingInfo targetInfo = new MobileAdTargetingInfo(
    testDevices: <String>[],
    keywords: <String>['Game'],
    nonPersonalizedAds: true,
  );

  BannerAd _bannerAd;

  BannerAd createBannerAd() {
    return new BannerAd(
        adUnitId: BannerAd.testAdUnitId,
        size: AdSize.banner,
        targetingInfo: targetInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd: $event");
        });
  }

  @override
  void initState() {
    _checkBiometrics();
    _getAvailableBiometrics();
    _getPass();

    // AD //
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: new Container(
        decoration: BoxDecoration(
            gradient: new LinearGradient(
          colors: [entryColor2[0], entryColor0[1]],
          begin: FractionalOffset.topLeft,
          end: FractionalOffset.bottomRight,
          stops: [0.0, 1],
          tileMode: TileMode.clamp,
        )),
        child: new Center(
            child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _logo(),
            _hasPass(context),
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
            image: new DecorationImage(image: AssetImage('assets/Lock.png'))));
  }

  _hasPass(context) {
    if (hasPass) {
      return Column(
        children: <Widget>[
          _loginPassField(),
          // Text('Current State: $_authorized\n'),
          SizedBox(
            height: 15,
          ),
          _loginButton(_userInputPass, context),
          SizedBox(
            height: 15,
          ),
          _loginFaceTouch(),
        ],
      );
    } else {
      return Text('Welcome!',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24));
    }
  }

  _loginPassField() {
    return Container(
      margin: EdgeInsets.only(top: 8.0, right: 8.0),
      width: MediaQuery.of(context).size.width * 0.75,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: Center(
              child: Text(
                'Password',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white),
              ),
            ),
          ),
          TextField(
            obscureText: true,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
            readOnly: false,
            decoration: InputDecoration(
              filled: true,
              fillColor: _searchBarColor,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: _searchBarColor),
                  borderRadius: BorderRadius.circular(8.0)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: _searchBarColor),
                  borderRadius: BorderRadius.circular(8.0)),
            ),
            onChanged: (String str) {
              setState(() {
                _userInputPass = str;
              });
            },
            onSubmitted: (String str) {
              if (passVaultPass == str) {
                _toApp();
              }
            },
          )
        ],
      ),
    );
  }

  _loginButton(inputPass, context) {
    return Center(
        child: SizedBox(
      height: 55,
      width: 230,
      child: FlatButton(
          color: Colors.white, //entryColor2[0],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              'Login With Password',
              style: TextStyle(
                  color: Color.fromRGBO(183, 172, 212, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
          ),
          onPressed: () {
            if (passVaultPass == inputPass) {
              _toApp();
            }
          }),
    ));
  }

  String _loginFaceTouchString() {
    if (_availableBiometrics.toString() == "[]") {
      return 'Biometrics N/A';
    } else {
      return 'Login With Biometrics';
    }
  }

  _loginAuth() {
    if (_availableBiometrics.toString() == "[]") {
      return SizedBox(
        height: 1,
      );
    } else {
      return _loginFaceTouch();
    }
  }

  _loginFaceTouch() {
    return Center(
        child: SizedBox(
      height: 55,
      width: 230,
      child: FlatButton(
        color: Colors.white, //entryColor2[0],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            _isAuthenticating ? 'Cancel' : _loginFaceTouchString(),
            style: TextStyle(
                color: Color.fromRGBO(183, 172, 212, 1),
                fontWeight: FontWeight.bold,
                fontSize: 17),
          ),
        ),
        onPressed: _isAuthenticating ? _cancelAuthentication : _authenticate,
      ),
    ));
  }
}
