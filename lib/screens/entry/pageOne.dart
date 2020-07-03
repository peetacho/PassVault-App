import 'package:flutter/material.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import '../app.dart';
import 'EntryPage.dart';

Color _searchBarColor = Color.fromRGBO(229, 233, 244, 1);

/////////////////////////////////////PAGE ONE////////////////////////////////
class PageOne extends StatefulWidget {
  PageOne({Key key}) : super(key: key);
  final JSONStorage jsonStorage = JSONStorage();

  @override
  PageOneState createState() => PageOneState();
}

class PageOneState extends State<PageOne> {
  String jsonStringString;
  @override
  void initState() {
    getJsonFileString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // Let the ListView know how many items it needs to build.
      itemCount: itemsDisplay.length + 1,
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index) {
        return index == 0 ? _searchBar(context) : _listItem(context, index - 1);
      },
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

    return Container(
        margin: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
        ),
        height: 120.0,
        child: Container(
            padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
            child: GradientCard(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(
                          Icons.star_half,
                          color: Colors.white,
                          size: 45,
                        ),
                        title: item.buildAccount(context),
                        subtitle: item.buildUser(context),
                        trailing: IconButton(
                            icon: Icon(Icons.more_vert, color: Colors.white),
                            onPressed: () {}),
                        isThreeLine: true,
                        onTap: () {
                          print(item);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EntryPage()));

                          // runApp(new MaterialApp(
                          //   debugShowCheckedModeBanner: false,
                          //   home: new EntryPage(),
                          // ));
                        },
                      ),
                    ]),
                elevation: 4.0,
                gradient: new LinearGradient(
                  colors: [entryColor[0], entryColor[1]],
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight,
                  stops: [0.0, 1],
                  tileMode: TileMode.clamp,
                ))));
  }
}
