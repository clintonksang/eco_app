import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class Loader extends StatelessWidget {
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
                        image: DecorationImage(
                            image: AssetImage("assets/pic1.jpg"),
                            fit: BoxFit.cover))),
              ],
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 0.0, top: 75),
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
                SizedBox(
                  height: 80,
                ),
                SpinKitFoldingCube(
                  duration: const Duration(milliseconds: 1200),
                  color: Colors.greenAccent[400],
                  size: 50,
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: Text('Please wait..',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Colors.white)))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
