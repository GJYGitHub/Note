import 'package:flutter/material.dart';
import 'package:note/config/app_config.dart';
import 'package:note/model/note_model.dart';
import 'package:provider/provider.dart';
import 'my_app.dart';

void main() {
  runApp(ChangeNotifierProvider<NoteProvider>(
    create:(context)=>GlobalConfig.note,
    child: MyApp(),
  ));
}
