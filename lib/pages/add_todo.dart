import 'package:flutter/material.dart';
import 'package:note/config/app_config.dart';
import 'package:note/model/note_database.dart';
import 'package:note/model/todo.dart';
import 'package:date_format/date_format.dart';

class AddTodoPage extends StatefulWidget {
  AddTodoPage({Key? key, this.hitTitle = '', this.hitDescription = ''})
      : super(key: key);
  String hitTitle;
  String hitDescription;

  @override
  _AddTodoPageState createState() => _AddTodoPageState(
      hitTitle: this.hitTitle, hitDescription: this.hitDescription);
}

class _AddTodoPageState extends State<AddTodoPage> {
  _AddTodoPageState({this.hitTitle = '', this.hitDescription = ''});

  DatabaseHelper helper = DatabaseHelper();
  Todo todo = Todo();
  String title = '';
  String description = '';
  String hitTitle;
  String hitDescription;

  ///保存插入的数据
  void _save() async {
    todo.title = this.title;
    todo.description = this.description;
    todo.date = DateTime.now().toString();

    ///将todo对象插入表中
    if (todo.title != "" && todo.description != "") {
      await helper.insertTodo(todo);
    }
    GlobalConfig.note.updateListView();
    Navigator.pop(context);
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
                hintText: '${hitTitle.length == 0 ? '标题' : hitTitle}',
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
                hintText:
                    '${hitDescription.length == 0 ? '记事' : hitDescription}',
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
