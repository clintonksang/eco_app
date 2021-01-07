import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EcoProjects extends StatefulWidget {
  @override
  _EcoProjectsState createState() => _EcoProjectsState();
}

class _EcoProjectsState extends State<EcoProjects> {
  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: 350.0,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: new Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(20.0),
                        topRight: const Radius.circular(20.0))),
                child: new Center(
                  child: new Text("This is a modal sheet"),
                )),
          );
        });
  }

  final Color white = Colors.white;
  final Color green = Colors.green[600];
  final Color lightgreen = Colors.green[400];
  final Color black = Colors.black;

  bool hascreatednursery = false;

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
        body: !hascreatednursery
            ? GestureDetector(
                onTap: () => _modalBottomSheetMenu(),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 80.0),
                    child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width - 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: lightgreen),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                "Start Project",
                                style: GoogleFonts.montserrat(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: IconButton(
                                  color: white,
                                  icon: Icon(
                                    Icons.add,
                                    size: 35,
                                  ),
                                  onPressed: () {}),
                            ),
                          ],
                        )),
                  ),
                ),
              )
            : Container());
  }
}

class Modalproperties extends StatefulWidget {
  @override
  _ModalpropertiesState createState() => _ModalpropertiesState();
}

class _ModalpropertiesState extends State<Modalproperties> {
  var selectedSchool, selectedType;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController textEditingController = TextEditingController();
  String textfromForm = "null";
  String school = "null";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
    );
  }
}
