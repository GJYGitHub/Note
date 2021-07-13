import 'package:flutter/material.dart';

class  SlidingAroundRoute extends PageRouteBuilder{
  final Widget widget;
  SlidingAroundRoute(this.widget):super(
      transitionDuration:Duration(seconds: 0),
      pageBuilder:(
          BuildContext context,
          Animation<double>animation1,
          Animation<double>animation2,
          ){
        return widget;
      },
      transitionsBuilder:(
          BuildContext context,
          Animation<double>animation1,
          Animation<double>animation2,
          Widget child
          ){
        //左右滑动路由动画
        return SlideTransition(
          position: Tween<Offset>(
            begin: Offset(1.0,0.0),
            end:Offset(0.0,0.0),
          ).animate(CurvedAnimation(
              parent: animation1,
              curve: Curves.fastOutSlowIn
          )),
          child: child,
        );
      }
  );

}