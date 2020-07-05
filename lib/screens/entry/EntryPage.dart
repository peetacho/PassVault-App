import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pageOne.dart';
import '../app.dart';

class EntryPage extends StatefulWidget {
  final item;
  final JSONStorage jsonStorage = JSONStorage();

  EntryPage(this.item);

  @override
  EntryPageState createState() => EntryPageState(item);
}

class EntryPageState extends State<EntryPage> {
  final item;

  Color _searchBarColor2 = Color.fromRGBO(229, 233, 244, 1);
  Color _searchBarColor = Colors.white;
  Color _background = Color.fromRGBO(240, 243, 250, 1);
  EntryPageState(this.item);

  final formKey = GlobalKey<FormState>();
  String _addedAccount,
      _addedEmail,
      _addedUsername,
      _addedPassword,
      _addedDescription;

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
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  Navigator.pop(context);
                }),
            actions: <Widget>[editSubmit(item.index)],
            elevation: 0.0,
            backgroundColor: Colors.white),
        body: ListView.builder(
            itemCount: 1,
            padding: EdgeInsets.all(0.0),
            itemBuilder: (context, index) {
              return Container(
                  height: MediaQuery.of(context).size.height * 1,
                  child: Form(
                      key: formKey,
                      child: Container(
                          color: _background,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              entryIcon(),
                              entryAccItem('Account', item.account),
                              entryUserItem('Username', item.user),
                              entryEmailItem('Email', item.email),
                              entryPassItem('Password', item.pass),
                              entryDescriptionItem(
                                  'Description', item.description),
                              deleteButton(item.index)
                            ],
                          ))));
            }));
  }

  entryIcon() {
    return Container(
        margin: EdgeInsets.only(top: 20, bottom: 15),
        width: 100.0,
        height: 100.0,
        decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            image: new DecorationImage(
              image: AssetImage('assets/instagram.png'),
              fit: BoxFit.fill,
            )));
  }

  deleteButton(acc) {
    return Container(
        margin: EdgeInsets.only(top: 15.0, bottom: 8.0),
        child: SizedBox(
          height: 55,
          width: MediaQuery.of(context).size.width * 0.85,
          child: FlatButton(
              color: entryColor2[0],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  'Delete Entry',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: () {
                _entryDelete(acc);
              }),
        ));
  }

  var _isFilled = true;

  editSubmit(acc) {
    if (_isEdit) {
      setState(() {
        (context as Element).reassemble();
      });
      return FlatButton(
        child: Text(
          'Edit',
          style: TextStyle(fontSize: 20.0),
        ),
        disabledTextColor: Colors.indigo,
        textColor: Colors.black,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: () {
          _toggleEdit();
        },
      );
    } else {
      return FlatButton(
        child: Text(
          'Submit',
          style: TextStyle(fontSize: 20.0, color: entryColor0[0]),
        ),
        disabledTextColor: Colors.indigo,
        textColor: Colors.blue[200],
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: () {
          _toggleEdit();
          _entrySubmit(acc);
        },
      );
    }
  }

  _entryDelete(acc) {
    // int currentEntryIndex = items.indexWhere((element) => element
    //     .buildAccount(context)
    //     .toString()
    //     .toLowerCase()
    //     .contains(acc.toString().toLowerCase()));
    // debugPrint('entry index, currentEntryIndex:  $currentEntryIndex');

    int currentEntryIndex = items.indexWhere((element) =>
        element.buildIndex(context).toString().contains(acc.toString()));

    // debugPrint('entry index, currentEntryIndex:  $currentEntryIndex');

    // debugPrint('items BEFORE delete: ' + items.toList().toString());

    items.removeAt(currentEntryIndex);
    itemsToJSON = jsonEncode(items);
    // debugPrint('items AFTER delete: ' + itemsToJSON);

    debugPrint('entry deleted');

    widget.jsonStorage.writeJSONStorage(itemsToJSON);
  }

  _entrySubmit(acc) {
    if (formKey.currentState.validate()) {
      //save form inputs
      formKey.currentState.save();
      // print(acc);
      debugPrint('entry submitted');

      int currentEntryIndex = items.indexWhere((element) =>
          element.buildIndex(context).toString().contains(acc.toString()));
      // debugPrint('entry index, currentEntryIndex:  $currentEntryIndex');

      items.removeAt(currentEntryIndex);

      //append entry item into items list
      items.insert(
          currentEntryIndex,
          EntryItem(_addedAccount, _addedEmail, _addedUsername, _addedPassword,
              _addedDescription, acc));

      //EntryItem objects converted to JSON string
      itemsToJSON = jsonEncode(items);
      //print(itemsToJSON);

      widget.jsonStorage.writeJSONStorage(itemsToJSON);

      formKey.currentState.reset();
    }
  }

  entryAccItem(label, item) {
    return Container(
      margin: EdgeInsets.only(top: 8.0, right: 8.0),
      width: MediaQuery.of(context).size.width * 0.85,
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
                input.length < 1 ? 'Please input account' : null,
            onSaved: (input) => _addedAccount = input,
            controller: (accountPaste != null)
                ? new TextEditingController(text: accountPaste)
                : new TextEditingController(text: item),
            readOnly: _isEdit,
            decoration: InputDecoration(
                filled: _isFilled,
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
      margin: EdgeInsets.only(top: 8.0, right: 8.0),
      width: MediaQuery.of(context).size.width * 0.85,
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
                input.length < 0 ? 'Please input username' : null,
            onSaved: (input) => _addedUsername = input,
            controller: (usernamePaste != null)
                ? new TextEditingController(text: usernamePaste)
                : new TextEditingController(text: item),
            readOnly: _isEdit,
            decoration: InputDecoration(
                filled: _isFilled,
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
      margin: EdgeInsets.only(top: 8.0, right: 8.0),
      width: MediaQuery.of(context).size.width * 0.85,
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
                input.length < 0 ? 'Please input email' : null,
            onSaved: (input) => _addedEmail = input,
            controller: (emailPaste != null)
                ? new TextEditingController(text: emailPaste)
                : new TextEditingController(text: item),
            readOnly: _isEdit,
            decoration: InputDecoration(
                filled: _isFilled,
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
      margin: EdgeInsets.only(top: 8.0, right: 8.0),
      width: MediaQuery.of(context).size.width * 0.85,
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
                input.length < 1 ? 'Please input password' : null,
            onSaved: (input) => _addedPassword = input,
            controller: (passwordPaste != null)
                ? new TextEditingController(text: passwordPaste)
                : new TextEditingController(text: item),
            readOnly: _isEdit,
            obscureText: _isHidden,
            decoration: InputDecoration(
                filled: _isFilled,
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
      margin: EdgeInsets.only(top: 8.0, right: 8.0),
      width: MediaQuery.of(context).size.width * 0.85,
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
                input.length < 0 ? 'Please input description' : null,
            onSaved: (input) => _addedDescription = input,
            readOnly: _isEdit,
            maxLines: 7,
            controller: (descriptPaste != null)
                ? new TextEditingController(text: descriptPaste)
                : new TextEditingController(text: item),
            decoration: InputDecoration(
                // contentPadding: const EdgeInsets.symmetric(vertical: 60.0),
                filled: _isFilled,
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
