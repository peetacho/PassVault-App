import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
// ignore: unused_import
import 'package:gradient_widgets/gradient_widgets.dart';
import '../app.dart';
import 'EntryPage.dart';
import 'jsonStorage.dart';

Color _searchBarColor = Color.fromRGBO(229, 233, 244, 1);
Color _indigoShadow = Color.fromRGBO(206, 214, 244, 0.6);

var images;

/////////////////////////////////////PAGE ONE////////////////////////////////
class PageOne extends StatefulWidget {
  PageOne({Key key}) : super(key: key);
  // final JSONStorage jsonStorage = JSONStorage();

  @override
  PageOneState createState() => PageOneState();
}

class PageOneState extends State<PageOne> {
  @override
  void initState() {
    _initImages();
    JSONStorage.readJSONStorage();
    super.initState();
  }

  Future _initImages() async {
    // >> To get paths you need these 2 lines
    final manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');

    final Map<String, dynamic> manifestMap = jsonDecode(manifestContent);
    // >> To get paths you need these 2 lines

    final imagePaths = manifestMap.keys
        // .where((String key) => key.contains('images/'))
        .where((String key) => key.contains('.png'))
        .toList();

    setState(() {
      images = imagePaths;
    });
  }

  Color _background = Color.fromRGBO(240, 243, 250, 1);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 1,
        color: _background,
        child: ListView.builder(
          // Let the ListView know how many items it needs to build.
          itemCount: itemsDisplay.length + 1,
          padding: EdgeInsets.all(0.0),
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            return Container(
              child: Container(
                child: Column(
                  children: <Widget>[
                    index == 0
                        ? _searchBar(context)
                        : _listItem(context, index - 1),
                  ],
                ),
              ),
            );
          },
        ));
  }

  _blank() {
    print('empty');
    return Center(
      child: Text('Add an entry!'),
    );
  }

  _searchBar(context) {
    return Container(
        margin: const EdgeInsets.only(
            left: 8.0, right: 8.0, top: 12.0, bottom: 12.0),
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0, right: 4.0),
          child: Theme(
            data: Theme.of(context).copyWith(splashColor: _searchBarColor),
            child: TextField(
              cursorColor: Colors.black,
              decoration: InputDecoration(
                  filled: true,
                  hintText: 'Search',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color.fromRGBO(129, 131, 152, 1),
                  ),
                  fillColor: _searchBarColor,
                  focusColor: _searchBarColor,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: _searchBarColor),
                      borderRadius: BorderRadius.circular(8.0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: _searchBarColor),
                      borderRadius: BorderRadius.circular(8.0))),
              onChanged: (text) {
                text = text.toLowerCase();
                setState(() {
                  itemsDisplay = items.where((item) {
                    var itemTitle =
                        item.buildAccount(context).toString().toLowerCase();

                    return itemTitle.contains(text);
                  }).toList();
                });
              },
            ),
          ),
        ));
  }

  _listItem(context, index) {
    final item = itemsDisplay[index];

    //_findImage(item);

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

    _entryDelete(acc, mode) {
      int currentEntryIndex = items
          .indexWhere((element) => element.getIndex().contains(acc.getIndex()));
      //print(acc.getIndex());
      //debugPrint('entry index, currentEntryIndex:  $currentEntryIndex');
      //debugPrint('items BEFORE delete: ' + items.toList().toString());
      items.removeAt(currentEntryIndex);
      itemsToJSON = jsonEncode(items);
      //debugPrint('items AFTER delete: ' + itemsToJSON);
      //debugPrint('entry deleted');
      JSONStorage.writeJSONStorage(itemsToJSON);

      if (mode == 1) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(seconds: 0),
            pageBuilder: (context, animation1, animation2) => App(),
          ),
        );
      }
    }

    return new Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      key: Key(item.buildAccount(context).toString()),
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
        onDismissed: (actionType) {
          _entryDelete(item, 2);
        },
      ),
      child: Container(
          margin: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
          ),
          //padding: EdgeInsets.only(top: 3.0, bottom: 5.0),
          height: MediaQuery.of(context).size.height * 0.17,
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    gradient: new LinearGradient(
                      colors: [entryColor[0], entryColor[1]],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      stops: [0.0, 1],
                      tileMode: TileMode.clamp,
                    )),
                child: FlatButton(
                    onPressed: () {
                      // print(item);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EntryPage(item)));
                    },
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Spacer(),
                          ListTile(
                            leading: _findImage(item),
                            title: item.buildAccount(context),
                            subtitle: item.buildUser(context),
                            isThreeLine: true,
                          ),
                          Spacer(),
                        ])),
              ))),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          foregroundColor: Colors.black,
          color: _indigoShadow,
          icon: Icons.delete,
          onTap: () {
            _entryDelete(item, 1);
          },
        ),
      ],
    );
  }

  _findImage(item) {
    String accountName = item.getAccount().toLowerCase().replaceAll(' ', '');
    int imageIndex;
    if (images != null) {
      imageIndex = images.indexWhere((element) => accountName.contains(
          element.toString().replaceAll('assets/', "").replaceAll('.png', "")));
    }
    if (imageIndex == -1) {
      return Icon(Icons.vpn_key, color: Colors.white, size: 50);
    } else {
      return Container(
          child: ColorFiltered(
        child: Tab(icon: Image.asset(images[imageIndex].toString())),
        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
      ));
    }
  }
}
