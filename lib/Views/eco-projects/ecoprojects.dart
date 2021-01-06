import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EcoProjects extends StatefulWidget {
  @override
  _EcoProjectsState createState() => _EcoProjectsState();
}

class _EcoProjectsState extends State<EcoProjects> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("ecoprojects"),
      ),
    );
  }
}
