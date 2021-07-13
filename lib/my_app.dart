import 'package:flutter/material.dart';
import 'package:note/pages/homepage.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'note_demo',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
