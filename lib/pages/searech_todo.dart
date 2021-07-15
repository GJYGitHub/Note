import 'package:flutter/material.dart';
import 'package:note/model/note_model.dart';
import 'package:note/widget/get_appbar.dart';
import 'package:note/widget/get_listview.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GetAppBar().getSearchAppBar(context),
      body: getSearchListView(),
    );
  }
}
