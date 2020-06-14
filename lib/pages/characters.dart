import 'package:flutter/material.dart';
import 'package:flutter_listview/models/rick_morty.dart';
import 'package:flutter_listview/repos/rick_morty_repo.dart';
import 'package:flutter_listview/widgets/character_card.dart';

class CharactersPage extends StatefulWidget {
  @override
  _CharactersPageState createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {

  ScrollController controller;

  List<Character> characters = [];
  int page = 0;
  bool isLoading = false;
  bool hasMorePages = false;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    fetchData();
    controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void fetchData() {
    setState(() {
      isLoading = true;
    });
    RickAndMortyRepo().getCharacters(page: page + 1).then((res) {
      page++;
      setState(() {
        isLoading = false;
        isLoadingMore = false;
        characters.addAll(res.results);
        hasMorePages = page < res.info.pages;
      });
    });
  }

  void _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent) {
      print("Reached end");
      if (!isLoadingMore && hasMorePages) {
        print("Fetching");
        setState(() {
          isLoadingMore = true;
        });
        fetchData();
      }
    }
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
          controller: controller,
          itemCount: characters.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == characters.length) {
              if (hasMorePages) {
                return CharacterCard(loading: true,);
              }
              return Container();
            }
            return CharacterCard(character: characters[index],);
          }
        ),
    );
  }
}
