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
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget> [
          ListTile(
            title: Text('Account'),
            leading: Icon(Icons.person),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            title: Text('Display'),
            leading: Icon(Icons.screen_lock_portrait),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          ListTile(
            title: Text('Apps'),
            leading: Icon(Icons.apps),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        ],
      )
    );
  }
}
