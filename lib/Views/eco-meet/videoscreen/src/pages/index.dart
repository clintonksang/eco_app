import 'dart:async';

// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
// import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import './call.dart';

class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<IndexPage> {
  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();

  /// if channel textField is validated to have error
  bool _validateError = false;

  ClientRole _role = ClientRole.Broadcaster;

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0,
        leading: IconButton(
          color: Colors.white,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Eco Meet",
          style: GoogleFonts.montserrat(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            "assets/video.png",
          ),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: Container(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: TextField(
                        controller: _channelController,
                        decoration: InputDecoration(
                            fillColor: Colors.green,
                            errorText: _validateError
                                ? 'Channel ID is mandatory'
                                : null,
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black),
                            ),
                            // labelText: 'Type here',
                            hintText: 'Channel ID',
                            hintStyle: TextStyle(color: Colors.grey)),
                      )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            onPressed: onJoin,
                            child: Text('Start'),
                            color: Colors.green[600],
                            textColor: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 90,
                  ),
                  Text('Enter or Join same ID to connect'),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 20),
                  //   child: Row(
                  //     children: <Widget>[
                  //       Expanded(
                  //         child: RaisedButton(
                  //           onPressed: () {
                  //             // Navigator.push(context,
                  //             //     MaterialPageRoute(builder: (context) => Appointments()));
                  //           },
                  //           child: Text(
                  //               'Create a  Link ID and share with your friends'),
                  //           color: Colors.grey,
                  //           textColor: Colors.white,
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    // update input validation
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic();
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallPage(
            channelName: _channelController.text,
            role: _role,
          ),
        ),
      );
    }
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }
}
