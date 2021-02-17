import 'package:cached_network_image/cached_network_image.dart';
import 'package:eco_app/Views/eco-schools/services/crud.dart';
import 'package:eco_app/Views/eco-schools/views/create_blog.dart';
import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";

class EcoSchools extends StatefulWidget {
  @override
  _EcoSchoolsState createState() => _EcoSchoolsState();
}

class _EcoSchoolsState extends State<EcoSchools> {
  CrudMethods crudMethods = new CrudMethods();

  Stream blogsStream;

  Widget BlogsList() {
    return Container(
      child: blogsStream != null
          ? Column(
              children: <Widget>[
                StreamBuilder(
                  stream: blogsStream,
                  builder: (context, snapshot) {
                    return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemCount: snapshot.data.documents.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return BlogsTile(
                            authorName: snapshot
                                .data.documents[index].data['authorName'],
                            title: snapshot.data.documents[index].data["title"],
                            description:
                                snapshot.data.documents[index].data['desc'],
                            imgUrl:
                                snapshot.data.documents[index].data['imgUrl'],
                          );
                        });
                  },
                )
              ],
            )
          : Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
    );
  }

  @override
  void initState() {
    crudMethods.getData().then((result) {
      setState(() {
        blogsStream = result;
      });
    });
    super.initState();
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
          "Eco Schools",
          style: GoogleFonts.montserrat(
            fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),
        ),
        centerTitle: true,
      ),
      body: BlogsList(),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FloatingActionButton(
                backgroundColor: Colors.green,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateBlog()));
                },
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BlogsTile extends StatelessWidget {
  String imgUrl, title, description, authorName;
  BlogsTile(
      {@required this.imgUrl,
      @required this.title,
      @required this.description,
      @required this.authorName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      height: 150,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              imageUrl: imgUrl,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 170,
            decoration: BoxDecoration(
                color: Colors.black45.withOpacity(0.3),
                borderRadius: BorderRadius.circular(6)),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(authorName)
              ],
            ),
          )
        ],
      ),
    );
  }
}
