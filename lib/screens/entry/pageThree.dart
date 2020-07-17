import 'dart:async';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/services.dart';
import '../app.dart';
import 'EntryPage.dart';
import 'names.dart';
import 'jsonStorage.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';

Color _searchBarColor = Color.fromRGBO(229, 233, 244, 1);

/////////////////////////////////////PAGE THREE////////////////////////////////

class PageThree extends StatefulWidget {
  PageThree({Key key}) : super(key: key);

  @override
  PageThreeState createState() => PageThreeState();
}

String userCheckPass = '';
String userCheckPassStrength = 'No input';

class PageThreeState extends State<PageThree> {
  @override
  void initState() {
    _generatePass();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(15.0),
        itemCount: 1,
        itemBuilder: (BuildContext ctxt, int index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _inputCheckPass(),
              Text(userCheckPassStrength,
                  style: TextStyle(color: Colors.red, fontSize: 50)),
              _inputGeneratePass(),
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
                        'Generate password',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    onPressed: () {
                      _generatePass();
                    }),
              )),
            ],
          );
        });
  }

  String pastedStrength;

  _inputCheckPass() {
    return Container(
      margin: EdgeInsets.only(top: 8.0, right: 8.0),
      width: MediaQuery.of(context).size.width * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: Text(
              'Check Password Strength',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
          ),
          TextField(
            onChanged: (String value) {
              setState(() {
                userCheckPass = value;
              });
              print(_checkPass());
              _checkStrength(_checkPass());
            },
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

  void copy(itm) {
    Clipboard.setData(new ClipboardData(text: itm));
  }

  int _checkPass() {
    List<String> _nouns = nouns;
    List<String> _adjectives = adjectives;
    List<String> _boyNames = Names.boyNames;
    List<String> _girlNames = Names.girlNames;

    var allWords = [..._nouns, ..._adjectives, ..._boyNames, ..._girlNames];

    int len = userCheckPass.length;
    int strengthScore = 0;

    int parseINT = int.tryParse(userCheckPass);
    if (len <= 17) {
      if (parseINT != null) {
        strengthScore = 1;
        return strengthScore;
      }
    }

    // String words = 'Words found: ';
    for (var i in allWords) {
      if (userCheckPass.toLowerCase().contains(i.toLowerCase())) {
        strengthScore -= 10;
        // words += ", " + i + " ";
      }
    }
    // debugPrint(words);

    // if (len <= 13 && RegExp(r'^[a-z]+$').hasMatch(userCheckPass)) {
    //   strengthScore = 8;
    //   return strengthScore;
    // }

    List<String> chars = [''];

    for (int i = 0; i < len; i++) {
      if (userCheckPass[i] == chars[i]) {
        // print('dupe!');
        strengthScore -= 5;
      }

      chars.add(userCheckPass[i]);
      // print(chars);

      if (len > 5 && len <= 7) {
        strengthScore += 1;
      } else if (len > 7 && len <= 13) {
        strengthScore += 2;
      } else if (len > 13) {
        strengthScore += 3;
      }
      strengthScore += 2;

      if (userCheckPass[i].contains(new RegExp(r'^[0-9]'))) {
        strengthScore += 5;
      }
      if (userCheckPass[i]
          .contains(new RegExp(r'^[!@#$%^&*?_<>~()., -+=|\`;:]'))) {
        strengthScore += 15;
      }
      if (userCheckPass[i].contains(new RegExp(r'^[A-Z]'))) {
        strengthScore += 15;
      }
    }
    return strengthScore;
  }

  _checkStrength(int strengthScore) {
    if (strengthScore > 100) {
      setState(() {
        userCheckPassStrength = 'Excellent';
      });
    } else if (strengthScore < 100 && strengthScore >= 75) {
      setState(() {
        userCheckPassStrength = 'Strong';
      });
    } else if (strengthScore < 75 && strengthScore >= 50) {
      setState(() {
        userCheckPassStrength = 'Good';
      });
    } else if (strengthScore < 50 && strengthScore >= 30) {
      setState(() {
        userCheckPassStrength = 'Moderate';
      });
    } else if (strengthScore < 30) {
      setState(() {
        userCheckPassStrength = 'Weak';
      });
    }
  }

  String generatedPass = '';
  var uuid = Uuid();
  var rand = new Random();

  _generatePass() {
    //generate uid section
    int range = rand.nextInt(3);
    String uid = uuid.v4().replaceAll('-', '').substring(0, range + 3);
    // print(uid);

    // generate wordPair
    String wordPair = WordPair.random().toString();

    // change random letters to uppercase in the range from 1 => wordPair.length
    int count = 1 + rand.nextInt(wordPair.length - 1);
    for (int i = 0; i < count; i++) {
      bool lowerUpper = rand.nextBool();
      if (lowerUpper) {
        wordPair =
            wordPair.replaceFirst(wordPair[i], wordPair[i].toUpperCase());
      }
    }

    List<String> specialChar = [
      '^',
      '!',
      '@',
      '#',
      '%',
      '^',
      '&',
      '*',
      '?',
      '_',
      '<',
      '>',
      '~',
      '(',
      ')',
      ".",
      ",",
      '-',
      '+',
      '=',
      '|'
    ];
    int specialCharRand = rand.nextInt(specialChar.length);

    String pass = wordPair + uid + specialChar[specialCharRand];

    setState(() {
      generatedPass = pass;
    });
  }

  _inputGeneratePass() {
    return Container(
      margin: EdgeInsets.only(top: 8.0, right: 8.0),
      width: MediaQuery.of(context).size.width * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 5.0),
            child: Text(
              'Generate Password',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
            ),
          ),
          TextField(
            controller: new TextEditingController(text: generatedPass),
            readOnly: true,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    icon: Icon(Icons.content_copy),
                    onPressed: () {
                      copy(generatedPass);
                    }),
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
}
