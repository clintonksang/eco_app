import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:eco_app/services/googlesignin/authmethods.dart';
import 'package:eco_app/services/googlesignin/utils/user_signout.dart';
import 'package:eco_app/services/googlesignin/utils/utils.dart';

class UserCircle extends StatefulWidget {
  @override
  _UserCircleState createState() => _UserCircleState();
}

class _UserCircleState extends State<UserCircle> {
  AuthMethods _auth = AuthMethods();

  String currentUserId;
  String img;
  String initials;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _auth.getCurrentUser().then((user) {
      setState(() {
        user.uid;
        img = user.photoUrl;
        initials = Utils.getInitials(user.displayName);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.grey,
        builder: (context) => UserDetailsContainer(),
      ),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        child: Stack(
          children: <Widget>[
            Material(
              borderRadius: BorderRadius.all(Radius.circular(180)),
              clipBehavior: Clip.hardEdge,
              child: CachedNetworkImage(
                placeholder: (context, url) => Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/placeholder.png"),
                  )),
                ),
                // url != null ? Image.network(url) : Container()
                imageUrl: img != null ? img : Container(),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2),
                    color: Color(0xff46dc64)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
