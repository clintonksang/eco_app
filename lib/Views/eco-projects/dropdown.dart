// // /// Flutter code sample for DropdownButton

// // // This sample shows a `DropdownButton` with a large arrow icon,
// // // purple text style, and bold purple underline, whose value is one of "One",
// // // "Two", "Free", or "Four".
// // //
// // // ![](https://flutter.github.io/assets-for-api-docs/assets/material/dropdown_button.png)

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// void main() => runApp(MyApp());

/// This is the main application widget.

/// This is the stateful widget that the main application instantiates.
class DropDown extends StatefulWidget {
  DropDown({Key key}) : super(key: key);

  @override
  _DropDownState createState() => _DropDownState();
}

/// This is the private State class that goes with DropDown.
class _DropDownState extends State<DropDown> {
  String dropdownValue = 'Nursey';

  @override
  Widget build(BuildContext context) {
    return 
    Column(
      children: [
        Row(
              children:[ 
                 Text(
                                           "Type",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Spacer(),
                DropdownButton<String>(
            value: dropdownValue,
            icon: Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
             style: GoogleFonts.montserrat(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                              underline: Container(
                                                height: 2,
                                                color: Colors.black,
                                              ),
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            items: <String>[
                  'Nursey',
                                                'Eco_Clean Up',
                                                'Tree Planting',
                                                'General'
            ]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
         
          
          ]
        ),
         Padding(
        padding: const EdgeInsets.only(top:160.0),
        child: Align(
          alignment: Alignment.bottomCenter,
                  child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: LinearGradient(colors: [
                Colors.greenAccent[400],
                Colors.green[800]
              ]),
              
            ),
            width:  MediaQuery.of(context).size.width-40,
            height: 50,
            child: Center(
              child: Text("Proceed",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
              ),
            ),
          ),
        ),
      )
      ],
    );
  }
}


