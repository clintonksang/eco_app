import 'package:eco_app/googlesignin/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateSchool extends StatefulWidget {
  @override
  _CreateSchoolState createState() => _CreateSchoolState();
}

class _CreateSchoolState extends State<CreateSchool> {
  var selectedSchool, selectedType;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController textEditingController = TextEditingController();
  String textfromForm = "null";
  String school = "null";
  // Future newtext() {
  //   setState(() {
  //     textfromForm = textEditingController.text;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(right: 0.0, top: 55),
                  child: Hero(
                    tag: "logo",
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
              ),
              Center(
                  child: Text('eco app',
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                              color: Colors.black)))),
              SizedBox(
                height: 30,
              ),
              Center(
                  child: Text('Whats your institution name?',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15,
                              color: Colors.grey[800])))),
              Center(
                child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 70,
                            padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                            decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.green)),
                            child: TextFormField(
                              controller: textEditingController,
                              style: TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                  hintText: 'Enter school/institution name',
                                  hintStyle: TextStyle(color: Colors.green)),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ),
                        ])),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(1),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, // background
                      onPrimary: Colors.black, // foreground
                    ),
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.

                      if (_formKey.currentState.validate()) {
                        // Process data.
                        //

                      }
                    },
                    child: Text(
                      'Submit',
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    //navigate
                    return LoginScreen(
                        // school: textEditingController.text,
                        );
                  }));
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
                    "Proceed",
                    style: GoogleFonts.montserrat(
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
    );
  }
}
