import 'package:note/model/todo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  late Database noteDatabase;

  Future<Database> initializeDatabase() async {
    String path = join(await getDatabasesPath(), 'note.noteDatabase');
    //创建并打开数据库
    noteDatabase = await openDatabase(path, version: 2,
        onCreate: (Database noteDatabase, int version) async {
      await noteDatabase.execute(
          'CREATE TABLE note_table(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, date TEXT)');
    });
    return noteDatabase;
  }

  ///将查询出来的Map类型数据转换成List类型
  Future<List<Todo>> getTodoList() async {
    var todoMapList = await getTodoMapList();
    int count = todoMapList.length;

    List<Todo> todoList = <Todo>[];
    for (int i = 0; i < count; i++) {
      todoList.add(Todo.fromMapObject(todoMapList[i]));
    }
    return todoList;
  }

  ///查
  Future<List<Map<String, dynamic>>> getTodoMapList() async {
    var result = await noteDatabase.query('note_table', orderBy: 'id ASC');
    return result;
  }

  ///通过关键字查询数据
  Future<List<Todo>?> getNoteByContent(String text) async {
    List<Todo> todoList = <Todo>[];
    if (text.length != 0) {
      var maps = await noteDatabase.query('note_table',
          where: 'description like ? ORDER BY date ASC',
          whereArgs: ["%" + text + "%"]);
      if (maps.length > 0) {
        for (int i = 0; i < maps.length; i++) {
          todoList.add(Todo.fromMapObject(maps.elementAt(i)));
        }
        return todoList;
      }
    }else{
      return null;
    }
  }

  ///改
  Future<int> updateTodo(Todo todo) async {
    var result = await noteDatabase.update('note_table', todo.toMap(),
        where: "id=?", whereArgs: [todo.id]); //通过id指定更新哪一项
    return result;
  }

  ///删
  Future<int> deleteTodo(int id) async {
    int result =
        await noteDatabase.delete('note_table', where: "id=?", whereArgs: [id]);
    return result;
  }

  ///增
  Future<int> insertTodo(Todo todo) async {
    var result = await noteDatabase.insert('note_table', todo.toMap());
    return result;
  }

  ///关闭数据库
  Future close() => noteDatabase.close();
}
