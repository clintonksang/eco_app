import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EcoTracker extends StatefulWidget {
  EcoTracker({
    Key key,
    this.titletext,
  }) : super(key: key); //update this to   include the uid in the constructor
  final String titletext;
  @override
  _EcoTrackerState createState() => _EcoTrackerState();
}

class _EcoTrackerState extends State<EcoTracker> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                  widget.titletext,
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
    );
  }
}
