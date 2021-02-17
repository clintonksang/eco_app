import 'package:eco_app/Views/eco-projects/nursery.dart';
import 'package:eco_app/utils/carroussel.dart';
import 'package:eco_app/widgets/NurseryRoute.dart';
import 'package:eco_app/widgets/RecyclingRoute.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class Elearning extends StatefulWidget {
  @override
  _ElearningState createState() => _ElearningState();
}

class _ElearningState extends State<Elearning> {
  final Color white = Colors.white;
  final Color green = Color(0x44E854);
  final Color mediumgreen = Colors.green[400];
  final Color lightgreen = Colors.green[100];
  final Color black = Colors.black;
  String newValue;
  bool hascreatednursery = false;
  bool hassubmited = false;

  var selectedSchool, selectedType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.white,
          title: Text(
            "Eco Projects",
            style: GoogleFonts.montserrat(
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.w300,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: StreamBuilder(
            stream: Firestore.instance.collection("posts").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                Text("Loading ..");
              }
              return Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Carroussel(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(NurseryRoute());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: black),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              "Nursery",
                              style: GoogleFonts.montserrat(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(RecyclingRoute());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Container(
                        height: 80,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.green[600]),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              "Recycling",
                              style: GoogleFonts.montserrat(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //
                ],
              );
            },
          ),
        ));
  }
}

//
