
import 'package:flutter/material.dart';

import 'Login.dart';

toLogin(BuildContext context,bool instant){
  Navigator.push(
      context,
      PageRouteBuilder(
          transitionDuration: Duration(seconds: instant ? 0 : 2),
          transitionsBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation,
              Widget child) {
            animation = CurvedAnimation(
                parent: animation,
                curve: Curves.elasticInOut
            );
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.centerLeft,
            );
          },
          pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation
              )
          {
            return Login();
          }
      )
  );
}