import 'package:eco_app/services/googlesignin/authmethods.dart';
import 'package:eco_app/services/googlesignin/utils/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:eco_app/Views/LandingPage.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  AuthMethods _repository = AuthMethods();
 _onLoading() {
    setState(() {
      isLoading = true;
      new Future.delayed(
        new Duration(seconds: 3),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loader()
        : Scaffold(
            body: Container(
              child: Stack(
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                                colorFilter: new ColorFilter.mode(
                                    Colors.black.withOpacity(0.9),
                                    BlendMode.dstATop),
                                image: AssetImage("assets/pic1.jpg"),
                                fit: BoxFit.cover)),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 0.0, top: 55),
                          child: Container(
                            width: 350,
                            height: 150,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage("assets/logo1.png"),
                            )),
                          ),
                        ),
                      ),
                      Center(
                          child: Text('eco app',
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 35,
                                      color: Colors.white)))),
                      Center(
                          child: Text('By \nGreenTowns\nInitiative',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: Colors.white)))),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 90.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isLoading = true;
                          });
                          performLogin();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.greenAccent[400],
                                  Colors.green[800],
                                ],
                              )),
                          width: MediaQuery.of(context).size.width - 40,
                          child: Text(
                            "Sign In with Google",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  void performLogin() {
    print("tring to perform login");
    _repository.signIn().then((FirebaseUser user) {
      print("something");
      if (user != null) {
        authenticateUser(user);
      } else {
        print("There was an error");
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
            msg: ' Sign In failed, \nKindly check your internet.');
      }
    });
  }

  void authenticateUser(FirebaseUser user) {
    _repository.authenticateUser(user).then((isNewUser) {
      if (isNewUser) {
        _repository.addDataToDb(user).then((value) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            //navigate
            return LandingPage();
          }));
          Fluttertoast.showToast(msg: 'Congrats Sign In Successful');
        });
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return LandingPage();
        }));
      }
    });
  }
}
