import 'package:flutter/material.dart';
import 'package:note/model/note_model.dart';
import 'package:note/pages/add_todo.dart';
import 'package:note/animation/rout_animation.dart';
import 'package:note/widget/get_appbar.dart';
import 'package:note/widget/get_listview.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    NoteProvider noteProvider = Provider.of<NoteProvider>(context);
    noteProvider.updateListView();
    return Scaffold(
      appBar: getAppBar(context),
      body: GetListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(SlidingAroundRoute(AddTodoPage()));
        },
        child: Icon(
          Icons.edit,
          color: Colors.black,
        ),
        backgroundColor: Color(Colors.amberAccent.value),
      ),
    );
  }
}
