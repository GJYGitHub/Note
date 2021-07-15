import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:note/model/note_database.dart';
import 'package:note/model/note_model.dart';
import 'package:note/model/todo.dart';
import 'package:note/pages/update_todo.dart';
import 'package:note/animation/rout_animation.dart';
import 'package:provider/provider.dart';

class GetListView extends StatefulWidget {
  const GetListView({Key? key}) : super(key: key);

  @override
  _GetListViewState createState() => _GetListViewState();
}

class _GetListViewState extends State<GetListView> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  void _delete(BuildContext context, Todo todo) async {
    var result = await databaseHelper.deleteTodo(todo.id);
    if (result != 0) {
      Provider.of<NoteProvider>(context, listen: false).updateListView();
    }
  }

  @override
  void initState() {
    databaseHelper.initializeDatabase();
    super.initState();
  }

  Widget getListView() {
    return Consumer<NoteProvider>(builder: (context, noteProvider, child) {
      return ListView.builder(
          itemCount: noteProvider.todoList.length,
          itemBuilder: (context, index) {
            final item = noteProvider.todoList[index];
            return Slidable(
              key: Key(item.id.toString()),
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.3,
              child: Card(
                  elevation: 0.4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .push(SlidingAroundRoute(UpdateTodoPage(
                            ///将点击后的ID，title，description传给下一个页面
                            id: item.id,
                            title: item.title,
                            description: item.description,
                          )));
                          print("Id=${item.id}");
                        },
                        title: Text(item.title),
                        subtitle: Text(
                          item.description,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 17.0, bottom: 10.0),
                        child: Text(
                          formatDate(DateTime.parse(item.date),
                              [yyyy, '年', m, '月', d, '日', ' ', HH, ':', nn]),
                          style: TextStyle(color: Colors.black26),
                        ),
                      )
                    ],
                  )),
              secondaryActions: <Widget>[
                // Card(
                //     elevation: 0.4,
                //     child: IconSlideAction(
                //       caption: '置顶',
                //       color: Colors.blue,
                //       icon: Icons.delete,
                //       onTap: () {
                //         print(index);
                //         print(item.id);
                //       },
                //     )),
                Card(
                    elevation: 0.4,
                    child: IconSlideAction(
                      caption: '删除',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () {
                        _delete(context, item);
                      },
                    )),
              ],
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return getListView();
  }
}

///展示搜索列表
Widget getSearchListView() {
  return Consumer<NoteProvider>(builder: (context, noteProvider, child) {
    return ListView.builder(
        itemCount: noteProvider.selectTodosList.length,
        itemBuilder: (context, index) {
          final item = noteProvider.selectTodosList[index];
          return Card(
              elevation: 0.4,
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(SlidingAroundRoute(UpdateTodoPage(
                    ///将点击后的ID，title，description传给下一个页面
                    id: item.id,
                    title: item.title,
                    description: item.description,
                  )));
                  print("Id=${item.id}");
                },
                title: Text(noteProvider.selectTodosList[index].title),
                subtitle: Text(
                  noteProvider.selectTodosList[index].description,
                  overflow: TextOverflow.ellipsis,
                ),
              ));
        });
  });
}
