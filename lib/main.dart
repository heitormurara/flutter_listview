import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ScrollController scrollController;
  final itemHeight = 80.0;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent && !scrollController.position.outOfRange) {
      print("End reached");
    } else if (scrollController.offset <= scrollController.position.minScrollExtent && !scrollController.position.outOfRange) {
      print("At the top");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Demo'),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.keyboard_arrow_up),
            onPressed: () {
              scrollController.animateTo(
                scrollController.offset - itemHeight, 
                duration: Duration(milliseconds: 500), 
                curve: Curves.easeIn,
              );
            },
          ),
          SizedBox(height: 8,),
          FloatingActionButton(
            child: Icon(Icons.keyboard_arrow_down),
            onPressed: () {
              scrollController.animateTo(
                scrollController.offset + itemHeight, 
                duration: Duration(milliseconds: 500), 
                curve: Curves.easeIn,
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        controller: scrollController,
        itemExtent: itemHeight,
        itemCount: 50,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('Item $index'),
          );
        })
    );
  }
}
