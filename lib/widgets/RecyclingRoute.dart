import 'package:eco_app/Views/eco-projects/Recycling.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecyclingRoute extends CupertinoPageRoute {
  RecyclingRoute() : super(builder: (BuildContext context) => new Recycling());

  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(opacity: animation, child: new Recycling());
  }
}
