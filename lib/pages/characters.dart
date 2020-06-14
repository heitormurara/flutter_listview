import 'package:flutter/material.dart';
import 'package:flutter_listview/models/rick_morty.dart';
import 'package:flutter_listview/repos/rick_morty_repo.dart';
import 'package:flutter_listview/widgets/character_card.dart';

class CharactersPage extends StatefulWidget {
  @override
  _CharactersPageState createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {

  List<Character> characters = [];
  int page = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    setState(() {
      isLoading = true;
    });
    RickAndMortyRepo().getCharacters(page: page + 1).then((res) {
      page++;
      setState(() {
        isLoading = false;
        characters.addAll(res.results);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rick and Morty"),
      ),
      body: isLoading 
      ? Center(child: CircularProgressIndicator(),) 
      : ListView.builder(
          itemCount: characters.length,
          itemBuilder: (BuildContext context, int index) {
            return CharacterCard(character: characters[index],);
          }
        ),
    );
  }
}
