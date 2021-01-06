import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:eco_app/services/googlesignin/authmethods.dart';
import 'package:eco_app/googlesignin/login.dart';
import 'package:eco_app/services/googlesignin/utils/customappbar.dart';

class UserDetailsContainer extends StatefulWidget {
  @override
  _UserDetailsContainerState createState() => _UserDetailsContainerState();
}

class _UserDetailsContainerState extends State<UserDetailsContainer> {
  final AuthMethods authMethods = AuthMethods();
  void signOut() {
    setState(() {
      authMethods.signOut();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        margin: EdgeInsets.only(top: 25),
        child: Column(
          children: <Widget>[
            CustomAppBar(
              leading: IconButton(
                icon: Icon(
                  //
                  //
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.maybePop(context),
              ),
              centerTitle: true,
              title: Container(
                //
                // new changes delete
                width: 150,
                height: 135,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/logo1.png"),
                )),
              ),
              actions: <Widget>[
                //
                //
                FlatButton(
                  onPressed: () {
                    signOut();
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    }));
                    Fluttertoast.showToast(msg: 'Sign Out Successful');
                  },
                  child: Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  ),
                )
              ],
            ),
            UserDetailsBody(),
          ],
        ),
      ),
    );
  }
}

class UserDetailsBody extends StatefulWidget {
  @override
  _UserDetailsBodyState createState() => _UserDetailsBodyState();
}

class _UserDetailsBodyState extends State<UserDetailsBody> {
  final AuthMethods authMethods = AuthMethods();
  String img;
  String allnames;
  String lastName;
  String nameSplit;
  String _email;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    authMethods.getCurrentUser().then((user) async {
      setState(() {
        allnames = user.displayName;
        img = user.photoUrl;
        lastName = user.displayName.split(" ")[0];
        _email = user.email;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        children: [
          CachedNetworkImage(
            placeholder: (context, url) => Container(),
            imageUrl: img != null ? img : CircularProgressIndicator(),
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                allnames,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                _email,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
