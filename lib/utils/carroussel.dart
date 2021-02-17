import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

class Carroussel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0, top: 5),
      child: CarouselSlider(
        items: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/aceacessories.appspot.com/o/EcoProjectsNurseryPictures%2Fplanting.jpg?alt=media&token=71653035-04f5-4e39-8f5d-79964fce5953" ??
                          AssetImage("assers/meet.jpg")),
                  fit: BoxFit.fill,
                )),
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Text("Learn about\nConservation Techniques",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      textAlign: TextAlign.center),
                )),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/aceacessories.appspot.com/o/EcoProjectsNurseryPictures%2Fmanagement.jpg?alt=media&token=145c8be9-8289-458c-bfff-3c1a711e4f38" ??
                          AssetImage("assers/meet.jpg")),
                  fit: BoxFit.fill,
                )),
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Text("Know how to \nManage a Nursery",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      textAlign: TextAlign.center),
                )),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/aceacessories.appspot.com/o/EcoProjectsNurseryPictures%2Frecycling.jpg?alt=media&token=f037acd3-41b6-4eab-9533-b40c9de9f01b' ??
                          AssetImage("assers/meet.jpg")),
                  fit: BoxFit.fill,
                )),
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25.0),
                  child: Text("Practise  \nRecycling ",
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      textAlign: TextAlign.center),
                )),
          ),
        ],
        options: CarouselOptions(
          aspectRatio: 16 / 9,
          viewportFraction: 0.8,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 4),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
