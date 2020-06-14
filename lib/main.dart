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

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Demo'),
      ),
      body: ListView.separated (
        itemCount: 50,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text('$index'),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          if (index % 5 == 0 && index != 0) return _buildAndBanner();
          return Divider(thickness: 1,);
        },
      )
    );
  }

  Widget _buildAndBanner() {
    return Card(
      color: Colors.grey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Text('Sponsored'),
            SizedBox(height: 16),
            Container(
              height: 100,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
