import 'package:flutter/material.dart';
import 'package:note/animation/rout_animation.dart';
import 'package:note/model/note_model.dart';
import 'package:note/pages/searech_todo.dart';
import 'package:provider/provider.dart';

class GetAppBar {
  ///HomePage的标题栏
  PreferredSizeWidget getAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        '便签',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context).push(SlidingAroundRoute(SearchPage()));
            },
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ))
      ],
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0.0,
    );
  }
  ///搜索界面的标题栏
  PreferredSizeWidget getSearchAppBar(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: IconButton(
          splashRadius: 30.0,
          onPressed: () {
            Navigator.of(context).pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          )),
      title: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0), color: Colors.black12),
        height: 38.0,
        child: TextField(
          autofocus: true,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: '搜索关键字',
              border: InputBorder.none),
          onChanged: (value) {
            Provider.of<NoteProvider>(context, listen: false)
                .selectListView(value);
          },
        ),
      ),
    );
  }
}
