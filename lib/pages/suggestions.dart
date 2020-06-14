import 'package:flutter/material.dart';

class SuggestionsPage extends StatefulWidget {
  @override
  _SuggestionsPageState createState() => _SuggestionsPageState();
}

class _SuggestionsPageState extends State<SuggestionsPage> {
  final _textController = TextEditingController();
  List<String> names = ['James Haywire', 'Fela Kuti'];

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void insertName(String value) {
    names.insert(0, value);
    setState(() {});
  }

  void removeName(int index) {
    names.removeAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send Character Suggestion"),
      ),
      body: Column(
        children: <Widget>[
          names.length == 0
              ? Expanded(
                  child: Center(
                    child: Text("No Characters Yet"),
                  ),
                )
              : Container(),
          Expanded(
            child: ListView.builder(
              itemCount: names.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildItem(names[index], index);
              },
            ),
          ),
          _buildTextBox(),
        ],
      ),
    );
  }

  Widget _buildItem(String name, int index) {
    return Card(
      elevation: 3,
      child: ListTile(
        title: Text(name),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            removeName(index);
          },
        ),
      ),
    );
  }

  Widget _buildTextBox() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextField(
        controller: _textController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter New Character Name',
        ),
        onSubmitted: (value) {
          _textController.clear();
          insertName(value);
        },
      ),
    );
  }
}