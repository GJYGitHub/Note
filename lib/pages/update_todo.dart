import 'dart:math';

import 'package:flutter/material.dart';
import 'package:note/config/app_config.dart';
import 'package:note/model/note_database.dart';
import 'package:note/model/todo.dart';
import 'package:date_format/date_format.dart';

class UpdateTodoPage extends StatefulWidget {
  UpdateTodoPage(
      {Key? key, this.title = '', this.description = '', this.id = 0})
      : super(key: key);
  int id;
  String title;
  String description;

  @override
  _UpdateTodoPageState createState() => _UpdateTodoPageState(
      id: this.id, title: this.title, description: this.description);
}

class _UpdateTodoPageState extends State<UpdateTodoPage> {
  _UpdateTodoPageState({this.title = '', this.description = '', this.id = 0});

  DatabaseHelper helper = DatabaseHelper();
  Todo todo = Todo();
  int id;
  String title;
  String description;

  ///保存修改的数据
  void _save() async {
    todo.id = this.id;
    todo.title = this.title;
    todo.description = this.description;
    todo.date = DateTime.now().toString();

    ///将todo对象插入表中
    if (todo.title != "" && todo.description != "") {
      await helper.updateTodo(todo);
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
            onChanged: (value) {
              this.title = value;
            },
            ///显示修改前的文本，保持光标在最后
            controller: TextEditingController.fromValue(TextEditingValue(
                text: this.title,
                selection: TextSelection.fromPosition(TextPosition(
                    offset: this.title.length,
                    affinity: TextAffinity.downstream)))),


            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),

            ///正在编辑的文本样式
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            cursorColor: Color(Colors.amber.value),
            cursorHeight: 23.0,
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
            maxLines: null,///无行数限制
            onChanged: (value) {
              this.description = value;
            },
            ///显示修改前的文本，保持光标在最后
            controller: TextEditingController.fromValue(TextEditingValue(
                text: this.description,
                selection: TextSelection.fromPosition(TextPosition(
                    offset: this.description.length,
                    affinity: TextAffinity.downstream)))),

            ///无行数限制
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            cursorColor: Color(Colors.amber.value),
            cursorHeight: 20.0,
          )
        ],
      ),
    );
  }
}
