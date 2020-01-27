import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:startup_namer/Calender.dart';
import 'package:startup_namer/FirebaseScreen.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'WidgetScreenUi.dart';
import 'productScreen.dart';

// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

void main() => initializeDateFormatting().then((_) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Welcome to Flutter',
        theme: ThemeData(
          // Add the 3 lines from here...
          primaryColor: Colors.white,
        ),
        home: RandomWords());
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved,
          ),
          IconButton(
            icon: Icon(Icons.book),
            onPressed: _navigateTowidgetUiScreen,
          )
        ],
      ),
      body: _buildHomeScreen(),
    );
  }

  void navigateToProductScreen() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => ShoppingList(
              products: <Product>[
                Product(name: "T-shirt"),
                Product(name: "shoes"),
                Product(name: "watch"),
              ],
            )));
  }

  void navigateToFireBaseScreen() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => FireBaseScreen()));
  }

  void _navigateTowidgetUiScreen() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => WidgetScreenUiScaffold()));
  }

  void _navigateToCalender() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => CalenderScreen()));
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _saved.map(
        (WordPair wordPair) {
          return ListTile(
            title: Text(
              wordPair.asPascalCase,
              style: _biggerFont,
            ),
          );
        },
      );
      final List<Widget> divided = ListTile.divideTiles(
        context: context,
        tiles: tiles,
      ).toList();
      return Scaffold(
        // Add 6 lines from here...
        appBar: AppBar(
          title: Text('Saved Suggestions'),
        ),
        body: ListView(children: divided),
      );
    }));
  }

  Widget _buildHomeScreen() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
                child: Container(
                    margin: EdgeInsets.all(8),
                    child: RaisedButton(
                      onPressed: navigateToProductScreen,
                      child: Text("products screen"),
                    ))),
            Expanded(
                child: Container(
                    margin: EdgeInsets.all(8),
                    child: RaisedButton(
                      onPressed: navigateToProductScreen,
                      child: Text("Details Screen"),
                    ))),
            Expanded(
                child: Container(
                    child: RaisedButton(
              padding: EdgeInsets.all(8),
              onPressed: navigateToFireBaseScreen,
              child: Text("FireBase"),
            ))),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[Expanded(
              child: Container(
                  margin: EdgeInsets.all(8),
                  child: RaisedButton(
                    onPressed: _navigateToCalender,
                    child: Text("Calender"),
                  ))),],
        ),
        Expanded(
          child: _buildSuggestions(),
        ),
      ],
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd)
            return Divider(
              color: Color(0x000000),
            );
          /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: InkWell(
        child: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null),
        onTap: () {
          setState(() {
            addRemoveToSavedList(alreadySaved, pair);
          });
        },
      ),
    );
  }

  void addRemoveToSavedList(bool alreadySaved, WordPair pair) {
    //set state to update the UI
    if (alreadySaved) {
      _saved.remove(pair);
    } else {
      _saved.add(pair);
    }
  }
}
