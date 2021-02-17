import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:eco_app/widgets/connectiontest.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Recycling extends StatefulWidget {
  @override
  _RecyclingState createState() => _RecyclingState();
}

class _RecyclingState extends State<Recycling> {
  //Youtube
  YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: '6jQ7y_qQYUA' ??
          // 'sG0dgLLrrsk&t=18s'??
          "https://images.unsplash.com/photo-1604187351574-c75ca79f5807?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
      // id youtube video
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ));
  //Youtube

  CollectionReference firestoreref = Firestore.instance.collection("recycling");

  //check if offline
  StreamSubscription _connectionChangeStream;
  bool isOffline = false;

  @override
  void initState() {
    super.initState();

    ConnectionStatusSingleton connectionStatus =
        ConnectionStatusSingleton.getInstance();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isOffline
        ? FlareActor(
            "assets/offline.flr",
            alignment: Alignment.center,
            fit: BoxFit.contain,
            animation: "offline",
          )
        : Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: FutureBuilder(
                future: firestoreref.getDocuments(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text("Error: ${snapshot.error}"),
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(snapshot.data.documents[0]
                                          ["img1"] ??
                                      CircularProgressIndicator()))),
                          child: Center(
                            child: Text(
                              snapshot.data.documents[0]["title"],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: Text(
                            "Watch Video",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                              width: MediaQuery.of(context).size.width - 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: YoutubePlayer(
                                controller: _controller,
                                showVideoProgressIndicator: true,
                                progressIndicatorColor: Colors.green,
                              ),
                            ) ??
                            CircularProgressIndicator(),
                        SizedBox(height: 15),
                        Center(
                          child: Text(
                            "Step 1",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            snapshot.data.documents[0]["description1"],
                            textAlign: TextAlign.start,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w300,
                                fontSize: 15,
                                color: Colors.black),
                          ),
                        ),

                        //
                        Center(
                          child: Text(
                            "Step 2",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            snapshot.data.documents[0]["description2"],
                            textAlign: TextAlign.start,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w300,
                                fontSize: 15,
                                color: Colors.black),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Step 3",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            snapshot.data.documents[0]["description3"],
                            textAlign: TextAlign.start,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w300,
                                fontSize: 15,
                                color: Colors.black),
                          ),
                        ),
                        Center(
                          child: Text(
                            "Step 4",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            snapshot.data.documents[0]["description4"],
                            textAlign: TextAlign.start,
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w300,
                                fontSize: 15,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 60.0),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
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
                                  "Done",
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
                    );
                  }

                  return Scaffold(
                      body: Center(child: CircularProgressIndicator()));
                },
              ),
            ));
  }
}
