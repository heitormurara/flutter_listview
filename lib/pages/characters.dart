import 'package:flutter/material.dart';

class CharactersPage extends StatefulWidget {
  @override
  _CharactersPageState createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rick and Morty"),
      ),
      body: Container(),
    );
  }
}