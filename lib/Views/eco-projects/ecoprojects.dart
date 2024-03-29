import 'package:eco_app/Views/eco-projects/dropdown.dart';
import 'package:eco_app/Views/eco-projects/maintenance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EcoProjects extends StatefulWidget {
  @override
  _EcoProjectsState createState() => _EcoProjectsState();
}

class _EcoProjectsState extends State<EcoProjects> {
  final Color white = Colors.white;
  final Color green = Color(0x44E854);
  final Color mediumgreen = Colors.green[400];
  final Color lightgreen = Colors.green[100];
  final Color black = Colors.black;
  String newValue;
  bool hascreatednursery = false;
  bool hassubmited = false;

  var selectedSchool, selectedType;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController textEditingController = TextEditingController();
  String textfromForm = "null";
  String school = "null";
  _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return SingleChildScrollView(
            child: new Container(
              height: 600.0,
              color:
                  Colors.transparent, //could change this to Color(0xFF737373),
              //so you don't have to change MaterialApp canvasColor
              child: new Container(
                  decoration: new BoxDecoration(
                      color: lightgreen,
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(20.0),
                          topRight: const Radius.circular(20.0))),
                  child: Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child:

                          //begins here
                          !hassubmited
                              ? Column(
                                  children: [
                                    Center(
                                      child: Form(
                                          key: _formKey,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      70,
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 2, 10, 2),
                                                  decoration: BoxDecoration(
                                                      color: Colors.green[50],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          color: Colors.green)),
                                                  child: TextFormField(
                                                    controller:
                                                        textEditingController,
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                    decoration:
                                                        const InputDecoration(
                                                            hintText:
                                                                'Name of your eco_project',
                                                            hintStyle: TextStyle(
                                                                color: Colors
                                                                    .green)),
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
                                            onPrimary:
                                                Colors.black, // foreground
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              hassubmited = true;
                                            });

                                            if (_formKey.currentState
                                                .validate()) {
                                              // Process data.

                                              // Pass to firebase

                                              //

                                            }
                                            FocusScopeNode currentFocus =
                                                FocusScope.of(context);
                                            if (!currentFocus.hasPrimaryFocus) {
                                              currentFocus.unfocus();
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
                                )
                              : Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Text(
                                          textEditingController.text,
                                          style: GoogleFonts.montserrat(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: black,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(24.0),
                                          child: GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                                hascreatednursery = true;
                                              },
                                              child: DropDown()),
                                        )
                                      ],
                                    ),
                                  ),
                                ))),
            ),
          );
        });
  }

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
      body: Column(
        children: [
          Column(
            children: [
              Hero(
                tag: "schools",
                child: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage("assets/students2.jpg"),
                    ),
                  ),
                ),
              ),
              // SizedBox(height: 5,),

              Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.green[400]),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        "Joan's Projects",
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(new MaintenanceRoute());
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Container(
                height: 80,
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: black),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      "Maintenance",
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
        ],
      ),
      //  !hascreatednursery
      //     ? GestureDetector(
      //         onTap: () => _modalBottomSheetMenu(),
      //         child: Align(
      //           alignment: Alignment.topCenter,
      //           child: Padding(
      //             padding: const EdgeInsets.only(top: 80.0),
      //             child: Container(
      //                 height: 50,
      //                 width: MediaQuery.of(context).size.width - 40,
      //                 decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(8),
      //                     color: mediumgreen),
      //                 child: Row(
      //                   children: [
      //                     Padding(
      //                       padding: const EdgeInsets.only(left: 15.0),
      //                       child: Text(
      //                         "Start Project",
      //                         style: GoogleFonts.montserrat(
      //                           fontSize: 25,
      //                           color: Colors.white,
      //                           fontWeight: FontWeight.w500,
      //                         ),
      //                       ),
      //                     ),
      //                     Spacer(),
      //                     Padding(
      //                       padding: const EdgeInsets.only(right: 15.0),
      //                       child: IconButton(
      //                           color: white,
      //                           icon: Icon(
      //                             Icons.add,
      //                             size: 35,
      //                           ),
      //                           onPressed: () {}),
      //                     ),
      //                   ],
      //                 )),
      //           ),
      //         ),
      //       )
      //     : EcoTracker(
      //         titletext: textEditingController.text,
      //       )
    );
  }
}

class MaintenanceRoute extends CupertinoPageRoute {
  MaintenanceRoute()
      : super(builder: (BuildContext context) => new EcoProjects());

  // OPTIONAL IF YOU WISH TO HAVE SOME EXTRA ANIMATION WHILE ROUTING
  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return new FadeTransition(opacity: animation, child: new Maintenance());
  }
  //         );

}
