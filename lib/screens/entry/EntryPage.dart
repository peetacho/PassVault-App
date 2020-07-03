import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pageOne.dart';

Color _searchBarColor = Color.fromRGBO(229, 233, 244, 1);

class EntryPage extends StatefulWidget {
  final item;

  EntryPage(this.item);

  @override
  EntryPageState createState() => EntryPageState(item);
}

class EntryPageState extends State<EntryPage> {
  final item;

  EntryPageState(this.item);

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
                  _toggleEdit();
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
                  entryAccItem('Account', item.account),
                  entryUserItem('Username', item.user),
                  entryEmailItem('Email', item.email),
                  entryPassItem('Password', item.pass),
                  entryDescriptionItem('Description', item.description),
                ],
              );
            }));
  }

  entryAccItem(label, item) {
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
            controller: (accountPaste != null)
                ? new TextEditingController(text: accountPaste)
                : new TextEditingController(text: item),
            readOnly: _isEdit,
            decoration: InputDecoration(
                filled: true,
                hintText: item,
                suffixIcon: IconButton(
                    icon: Icon(
                      _copyPaste,
                      color: Color.fromRGBO(129, 131, 152, 1),
                    ),
                    onPressed: () {
                      if (_isEdit) {
                        // if on edit, able to copy item
                        copy(item);
                        debugPrint('copy ' + item);
                      } else {
                        // if not on edit, able to paste item
                        paste().then((String result) {
                          setState(() {
                            accountPaste = result;
                          });
                        });
                      }
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

  entryUserItem(label, item) {
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
            controller: (usernamePaste != null)
                ? new TextEditingController(text: usernamePaste)
                : new TextEditingController(text: item),
            readOnly: _isEdit,
            decoration: InputDecoration(
                filled: true,
                hintText: item,
                suffixIcon: IconButton(
                    icon: Icon(
                      _copyPaste,
                      color: Color.fromRGBO(129, 131, 152, 1),
                    ),
                    onPressed: () {
                      if (_isEdit) {
                        // if on edit, able to copy item
                        copy(item);
                        debugPrint('copy ' + item);
                      } else {
                        // if not on edit, able to paste item
                        paste().then((String result) {
                          setState(() {
                            usernamePaste = result;
                          });
                        });
                      }
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

  entryEmailItem(label, item) {
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
            controller: (emailPaste != null)
                ? new TextEditingController(text: emailPaste)
                : new TextEditingController(text: item),
            readOnly: _isEdit,
            decoration: InputDecoration(
                filled: true,
                hintText: item,
                suffixIcon: IconButton(
                    icon: Icon(
                      _copyPaste,
                      color: Color.fromRGBO(129, 131, 152, 1),
                    ),
                    onPressed: () {
                      if (_isEdit) {
                        // if on edit, able to copy item
                        copy(item);
                        debugPrint('copy ' + item);
                      } else {
                        // if not on edit, able to paste item
                        paste().then((String result) {
                          setState(() {
                            emailPaste = result;
                          });
                        });
                      }
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

  String newPass(bool) {
    if (bool) {
      String newPass = '';
      for (var i = 0; i < item.pass.length; i++) {
        newPass += '•';
      }
      return newPass;
    } else {
      return item.pass;
    }
  }

  var _visb = Icons.visibility_off;
  bool _isHidden = true;

  void _toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
      if (_visb == Icons.visibility_off) {
        _visb = Icons.visibility;
      } else {
        _visb = Icons.visibility_off;
      }
    });
  }

  entryPassItem(label, item) {
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
            controller: (passwordPaste != null)
                ? new TextEditingController(text: passwordPaste)
                : new TextEditingController(text: item),
            readOnly: _isEdit,
            obscureText: _isHidden,
            decoration: InputDecoration(
                filled: true,
                hintText: item,
                suffixIcon: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // added line
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          _visb,
                          color: Color.fromRGBO(129, 131, 152, 1),
                        ),
                        onPressed: () {
                          _toggleVisibility();
                        }),
                    IconButton(
                        icon: Icon(
                          _copyPaste,
                          color: Color.fromRGBO(129, 131, 152, 1),
                        ),
                        onPressed: () {
                          if (_isEdit) {
                            // if on edit, able to copy item
                            copy(item);
                            debugPrint('copy ' + item);
                          } else {
                            // if not on edit, able to paste item
                            paste().then((String result) {
                              setState(() {
                                passwordPaste = result;
                              });
                            });
                          }
                        }),
                  ],
                ),
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

  bool _isEdit = true;
  var _copyPaste = Icons.content_copy;

  void copy(itm) {
    Clipboard.setData(new ClipboardData(text: itm));
  }

  Future<String> paste() async {
    ClipboardData paste = await Clipboard.getData('text/plain');
    return paste.text;
  }

  void _toggleEdit() {
    setState(() {
      _isEdit = !_isEdit;

      if (_copyPaste == Icons.content_copy) {
        _copyPaste = Icons.content_paste;
      } else {
        _copyPaste = Icons.content_copy;
      }
    });
  }

  var accountPaste;
  var usernamePaste;
  var emailPaste;
  var passwordPaste;
  var descriptPaste;

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
            readOnly: _isEdit,
            maxLines: 7,
            controller: (descriptPaste != null)
                ? new TextEditingController(text: descriptPaste)
                : new TextEditingController(text: item),
            decoration: InputDecoration(
                // contentPadding: const EdgeInsets.symmetric(vertical: 60.0),
                filled: true,
                hintText: item,
                suffixIcon: IconButton(
                    icon: Icon(
                      _copyPaste,
                      color: Color.fromRGBO(129, 131, 152, 1),
                    ),
                    onPressed: () {
                      if (_isEdit) {
                        // if on edit, able to copy item
                        copy(item);
                        debugPrint('copy ' + item);
                      } else {
                        // if not on edit, able to paste item
                        paste().then((String result) {
                          setState(() {
                            descriptPaste = result;
                          });
                        });
                      }
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
