import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'eco-meet/videoscreen/src/pages/index.dart';

// VideoRoute
class VideoRoute extends CupertinoPageRoute {
  VideoRoute() : super(builder: (BuildContext context) => new IndexPage());

  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(opacity: animation, child: new IndexPage());
  }
}
