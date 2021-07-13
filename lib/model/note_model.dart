import 'package:flutter/material.dart';
import 'package:note/model/note_database.dart';
import 'package:note/model/todo.dart';
import 'package:sqflite/sqflite.dart';

class NoteProvider extends ChangeNotifier {
  DatabaseHelper databaseHelper = DatabaseHelper();
  late List<Todo> todos = <Todo>[];
  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((value) {
      Future<List<Todo>> todoList = databaseHelper.getTodoList();
      todoList.then((todoList) {
        todos = todoList;
        notifyListeners();
      });
    });
  }
  List<Todo> get todoList => todos;
}
