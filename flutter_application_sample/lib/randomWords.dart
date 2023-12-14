import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final randomWordPairs = <WordPair>[];
  final savedWordPairs = Set<WordPair>();
  Widget buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, item) {
        // if (item.isOdd) return Divider();
        //final index = item ~/ 2;

        if (item >= randomWordPairs.length && randomWordPairs.length < 25) {
          randomWordPairs.addAll(generateWordPairs().take(10));
        }
        if (item > 24) {
          return null;
        }
        return buildRow(randomWordPairs[item]);
      },
    );
  }

  Widget buildRow(WordPair pair) {
    final alreadySaved = savedWordPairs.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: const TextStyle(fontSize: 18),
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            savedWordPairs.remove(pair);
          } else {
            savedWordPairs.add(pair);
          }
        });
      },
    );
  }

  void pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = savedWordPairs.map((WordPair pair) {
        return ListTile(
            title: Text(
          pair.asPascalCase,
          style: TextStyle(fontSize: 16.0),
        ));
      });

      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();
      return Scaffold(
        appBar: AppBar(title: Text('Saved WordPairs')),
        body: ListView(
          children: divided,
        ),
      );
    }));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Word Pair Generation'),
        actions: <Widget>[
          IconButton(onPressed: pushSaved, icon: Icon(Icons.favorite))
        ],
      ),
      body: buildList(),
    );
  }
}
