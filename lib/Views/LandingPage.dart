import 'package:eco_app/Views/eco-projects/ecoprojects.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:eco_app/services/googlesignin/authmethods.dart';
import 'package:eco_app/services/googlesignin/utils/customappbar.dart';
import 'package:eco_app/services/googlesignin/utils/usercircle.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatefulWidget {
  LandingPage({
    Key key,
    this.lastName,
  }) : super(key: key); //update this to   include the uid in the constructor
  final String lastName;
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  AuthMethods _auth = AuthMethods();
  SharedPreferences preferences;
  String id = "";
  String nickname = "";
  String img;
  String initials;
  String lastName;
  String nameSplit;
  bool isLoading = false;

  void signOut() {
    setState(() {
      _auth.signOut();
    });
  }

  @override
  void initState() {
    //
    //
    super.initState();

    _auth.getCurrentUser().then((user) async {
      //
      //
      setState(() {
        user.uid;
        img = user.photoUrl;
        lastName = user.displayName.split(" ")[0];
      });
    });
  }

  CustomAppBar customAppBar(BuildContext context) {
    return CustomAppBar(
      leading: IconButton(
        icon: Icon(
          Icons.notifications,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      title: UserCircle(),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.exit_to_app, size: 30, color: Colors.white),
            onPressed: () {
              signOut();
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      // appBar: customAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 0.0),
                      child: Container(
                        width: 120,
                        height: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage("assets/logo1.png"),
                        )),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Text("Welcome $lastName",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontSize: 25.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey[800]),
                          )),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: GestureDetector(
                            onTap:
                                () {}, // url != null ? Image.network(url) : Container()
                            child: UserCircle(),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Profile",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey[800]),
                          )),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 30,
                //
                //
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 80,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(2)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text("Tumoiyot Primary",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Center(
                child: Text("Activities",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600]),
                    )),
              ),
              SizedBox(height: 15),

              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //         MaterialPageRoute(

                  //           builder:

                  //          (context) {
                  //       //navigate
                  //       return LoginScreen(
                  //           // school: textEditingController.text,
                  //           );
                  //     }
                  //     )

                  //         );
                  Navigator.of(context).push(new EcoProjectsRoute());
                },
                child: Center(
                  child: Container(
                      width: MediaQuery.of(context).size.width - 20,
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/students.jpg"))),
                      child: Center(
                          child: Text("Eco-Projects",
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )))),
                ),
              ),
              SizedBox(height: 15),

              Center(
                child: Container(
                    width: MediaQuery.of(context).size.width - 20,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/ecoschools.jpg"))),
                    child: Center(
                        child: Text("Eco-Schools",
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )))),
              ),
              SizedBox(height: 15),

              Center(
                child: Container(
                    width: MediaQuery.of(context).size.width - 20,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            // colorFilter: ColorFilter.mode(
                            //     Colors.black12, BlendMode.dstATop),
                            image: AssetImage("assets/meet.jpg"))),
                    child: Center(
                        child: Text("Eco-Meet",
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )))),
              ),
              //  SizedBox(height: 20.0),
              // Center(child: Profession()),

              SizedBox(height: 20.0),

              SizedBox(height: 40.0),

              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
class EcoProjectsRoute extends CupertinoPageRoute {
  EcoProjectsRoute()
      : super(builder: (BuildContext context) => new EcoProjects());

  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(opacity: animation, child: new EcoProjects());
  }
  //         );

}
//
