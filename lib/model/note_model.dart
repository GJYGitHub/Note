import 'package:flutter/material.dart';
import 'package:note/model/note_database.dart';
import 'package:note/model/todo.dart';
import 'package:sqflite/sqflite.dart';

class NoteProvider extends ChangeNotifier {
  DatabaseHelper databaseHelper = DatabaseHelper();
  late List<Todo> _todos = <Todo>[];
  late List<Todo> _selectTodos = <Todo>[];

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((value) {
      Future<List<Todo>> todoList = databaseHelper.getTodoList();
      todoList.then((list) {
        _todos = list;
        notifyListeners();
      });
    });
  }

  List<Todo> get todoList => _todos;

  void selectListView(String text) {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((value) {
      Future<List<Todo>?> todoList = databaseHelper.getNoteByContent(text);
      todoList.then((list) {
        _selectTodos = list!=null?list:[];
        notifyListeners();
      });
    });
  }

  List<Todo> get selectTodosList => _selectTodos;
}
