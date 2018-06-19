import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MaterialApp(
  home: new RandomWord(),
  title: 'Name Generator',
  theme: new ThemeData(
    primaryColor: Colors.red,
    accentColor: Colors.red
  ),
));



class RandomWord extends StatefulWidget {
  @override
  _RandomWordState createState() => _RandomWordState();
}

class _RandomWordState extends State<RandomWord> {
  final List<WordPair> _suggestions = <WordPair>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0); 
  final Set<WordPair> _saved = new Set<WordPair>();
  void _pushSaved(){
   Navigator.of(context).push(
    new MaterialPageRoute<void>(   // Add 20 lines from here...
      builder: (BuildContext context) {
        final Iterable<ListTile> tiles = _saved.map(
          (WordPair pair) {
            return new ListTile(
              title: new Text(
                pair.asPascalCase,
                style: _biggerFont,
              ),
            );
          },
        );
        final List<Widget> divided = ListTile
          .divideTiles(
            context: context,
            tiles: tiles,
          )
          .toList();
      },
    ),                           // ... to here.
  ); 
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildSuggestions(),
      appBar: new AppBar(backgroundColor: Colors.red,title: new Text("English Words"),
      actions: <Widget>[
        new IconButton(icon: new Icon(Icons.list),onPressed: _pushSaved,)
      ],),
    );
  }
  Widget _buildSuggestions(){
  return new ListView.builder(
    padding: const EdgeInsets.all(16.0),
    itemBuilder: (BuildContext _context, int i ){
      if (i.isOdd){
        return const Divider();
      }
      final int index = i ~/ 2;
      if(index >= _suggestions.length){
        _suggestions.addAll(generateWordPairs().take(10));
      }
      return _buildRow(_suggestions[index]);
    },
  );
}
Widget _buildRow(WordPair pair) {
  final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(   // Add the lines from here... 
      alreadySaved ? Icons.favorite : Icons.favorite_border,
      color: alreadySaved ? Colors.red : null,
    ),  
    onTap: (){
      setState(() {
        if(alreadySaved){
          _saved.remove(pair);
        } else{
          _saved.add(pair);
        }
      });
    },
    );
  }
}