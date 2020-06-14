import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_listview/models/rick_morty.dart';
import 'package:flutter_listview/repos/rick_morty_repo.dart';
import 'package:flutter_listview/widgets/character_card.dart';

class CharactersPage extends StatefulWidget {
  @override
  _CharactersPageState createState() => _CharactersPageState();
}

class _CharactersPageState 
  extends State<CharactersPage>
  with SingleTickerProviderStateMixin {

  ScrollController controller;
  AnimationController _hide;

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
    _hide = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100)
    );
  }

  @override
  void dispose() {
    controller.dispose();
    _hide.dispose();
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

  bool _onNotificationHandler(ScrollNotification notification) {
    if (notification.depth == 0 && notification is UserScrollNotification) {
      if (notification.direction == ScrollDirection.forward) {
        _hide.reverse();
      } else if (notification.direction == ScrollDirection.reverse) {
        _hide.forward();
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rick and Morty"),
      ),
      floatingActionButton: ScaleTransition(
        scale: _hide,
        child: FloatingActionButton(
          child: Icon(Icons.keyboard_arrow_up),
          onPressed: () {
            controller.animateTo(
              controller.initialScrollOffset, 
              duration: Duration(milliseconds: 500), 
              curve: Curves.easeIn);
          },
        ),
      ),
      body: isLoading 
      ? Center(child: CircularProgressIndicator(),) 
      : NotificationListener<ScrollNotification>(
        onNotification: _onNotificationHandler,
        child: 
          ListView.builder(
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
      )
    );
  }
}
