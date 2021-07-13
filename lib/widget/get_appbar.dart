import 'package:flutter/material.dart';

///空白焦点，不赋给任何focusNode
FocusNode blankNode = FocusNode();

double _width = 0;
double _height = 0;

PreferredSizeWidget getAppBar(BuildContext context) {
  return AppBar(
    title: Text(
      '便签',
      style: TextStyle(color: Colors.black),
    ),
    actions: [
      Container(
        height: _height,
        width: _width,
        color: Colors.transparent,
        child: TextField(
          onChanged: (v) {},
        ),
      ),
      IconButton(
          onPressed: () {
            if (_width == 0 && _height == 0) {
              _width = 240.0;
              _height = 60.0;
            } else {
              _width = 0.0;
              _height = 0.0;

              ///指定空白焦点，隐藏输入键盘
              FocusScope.of(context).requestFocus(blankNode);
            }
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
