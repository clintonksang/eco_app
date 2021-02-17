import 'package:eco_app/Views/eco-projects/nursery.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NurseryRoute extends CupertinoPageRoute {
  NurseryRoute() : super(builder: (BuildContext context) => new Nursery());

  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(opacity: animation, child: new Nursery());
  }
}
