import 'package:flutter/material.dart';
import 'package:note/config/app_config.dart';
import 'package:note/model/note_database.dart';
import 'package:note/model/todo.dart';
import 'package:date_format/date_format.dart';

class AddTodoPage extends StatefulWidget {
  AddTodoPage({Key? key}) : super(key: key);

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  DatabaseHelper helper = DatabaseHelper();
  Todo todo = Todo();
  String title = '';
  String description = '';

  ///保存插入的数据
  void _save() async {
    todo.title = this.title;
    todo.description = this.description;
    todo.date = DateTime.now().toString();

    ///将todo对象插入表中
    if (todo.title != "" && todo.description != "") {
      await helper.insertTodo(todo);
    }
    Navigator.pop(context);
    helper.close();
  }

  @override
  void initState() {
    helper.initializeDatabase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0.0,
        leading: IconButton(
            onPressed: _save,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset('images/elipsis-v.png', width: 25, height: 25)),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 0),
        children: [
          ///标题框
          TextField(
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),

            ///正在编辑的文本样式
            decoration: InputDecoration(
                hintText: '标题',
                hintStyle: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black26),
                border: InputBorder.none),
            cursorColor: Color(Colors.amber.value),
            cursorHeight: 23.0,
            onChanged: (value) {
              title = value;
            },
          ),
          Row(
            children: [
              SizedBox(
                child: Text(formatDate(DateTime.now(), [HH, ":", nn])),
              ),
            ],
          ),

          ///内容框
          TextField(
            maxLines: null,

            ///无行数限制
            decoration: InputDecoration(
                hintText: '记事',
                hintStyle: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black26),
                border: InputBorder.none),
            cursorColor: Color(Colors.amber.value),
            cursorHeight: 20.0,
            onChanged: (value) {
              description = value;
            },
          )
        ],
      ),
    );
  }
}
