import 'package:flutter/material.dart';
// change `flutter_database` to whatever your project name is
import 'package:testing_app/database_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFlite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;
  final intEditingController = TextEditingController();
  final textEditingController = TextEditingController();

  void dispose() {
    // Clean up the controller when the widget is disposed.
    intEditingController.dispose();
    textEditingController.dispose();
  }
  // homepage layout
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sqflite'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.text,
              controller: textEditingController,
            ),
            TextField(
               keyboardType: TextInputType.text,
              controller: intEditingController,
            ),
            RaisedButton(
              child: Text('insert', style: TextStyle(fontSize: 20),),
              onPressed: () {
                _insert(
                    textEditingController.text,
                    int.parse(intEditingController.text),

                );
                },
            ),
            RaisedButton(
              child: Text('query', style: TextStyle(fontSize: 20),),
              onPressed: () {_query();},
            ),
            RaisedButton(
              child: Text('update', style: TextStyle(fontSize: 20),),
              onPressed: () {_update();},
            ),
            RaisedButton(
              child: Text('delete', style: TextStyle(fontSize: 20),),
              onPressed: () {_delete();},
            ),
          ],
        ),
      ),
    );
  }

  // Button onPressed methods

  void _insert(String columnName, int columnAge) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : columnName,
      DatabaseHelper.columnAge  : columnAge
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
    allRows.toList();
  }

   _customQuery() async {
    final allRows = await dbHelper.queryAllRows();
    print(' Custom query all rows:');
    allRows.forEach((row) => print(row));
    allRows.toList();

  }


  void _update() async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : 1,
      DatabaseHelper.columnName : 'Mary',
      DatabaseHelper.columnAge  : 32
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }
}