import 'package:eco_app/Views/createschool.dart';
import 'package:eco_app/googlesignin/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Schools extends StatefulWidget {
  @override
  _SchoolsState createState() => _SchoolsState();
}

class _SchoolsState extends State<Schools> {
  var selectedCurrency, selectedType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                SizedBox(
                  height: 20,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance.collection("school").snapshots(),
                    // ignore: missing_return
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        Text("Loading.....");
                      else {
                        List<DropdownMenuItem> currencyItems = [];
                        for (int i = 0;
                            i < snapshot.data.documents.length;
                            i++) {
                          DocumentSnapshot snap = snapshot.data.documents[i];
                          currencyItems.add(
                            DropdownMenuItem(
                              child: Text(
                                snap.documentID,
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    // fontSize: 17,
                                    color: Colors.white),
                              ),
                              value: "${snap.documentID}",
                            ),
                          );
                        }
                        return Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(8)),
                          child: DropdownButton(
                            items: currencyItems,
                            onChanged: (schoolValue) {
                              final snackBar = SnackBar(
                                backgroundColor: Colors.black,
                                content: Text(
                                  'Selected School value is $schoolValue',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      // fontSize: 17,
                                      color: Colors.white),
                                ),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                              setState(() {
                                selectedCurrency = schoolValue;
                              });
                            },
                            value: selectedCurrency,
                            isExpanded: false,
                            hint: new Text(
                              "Click here to select",
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  // fontSize: 17,
                                  color: Colors.white),
                            ),
                          ),
                        );
                      }

                      Container();
                    }),
                SizedBox(
                  height: 35,
                ),
                Text("Didn't find your school?",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Colors.grey[800]))),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    //  Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return LoginScreen();
                    // }));
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      backgroundColor: Colors.grey,
                      builder: (context) => CreateSchool(),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.green[600],
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Click Here",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white))),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 90.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      //navigate
                      return LoginScreen();
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
      ),
    );
  }
}
