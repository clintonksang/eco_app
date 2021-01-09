import 'package:eco_app/Views/eco-projects/taskpage.dart';
import 'package:eco_app/utils/database_helper.dart';
import 'package:eco_app/utils/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Maintenance extends StatefulWidget {
  Maintenance({
    Key key,
    this.titletext,
  }) : super(key: key); //update this to   include the uid in the constructor
  final String titletext;
  @override
  _MaintenanceState createState() => _MaintenanceState();
}

class _MaintenanceState extends State<Maintenance> {
  @override
  void initState() {
    super.initState();
    _animate();
  }

  var loginWidth = 0.0;
  Curve _curve = Curves.fastOutSlowIn;
  _animate() {
    setState(() {
      loginWidth == 0.0 ? loginWidth = 130 : loginWidth = 0.0;
    });
  }

  DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green[100],
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          color: Colors.green[100],
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: FutureBuilder(
                      initialData: [],
                      future: _dbHelper.getTasks(),
                      builder: (context, snapshot) {
                        return ScrollConfiguration(
                          behavior: NoGlowBehaviour(),
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Taskpage(
                                        task: snapshot.data[index],
                                      ),
                                    ),
                                  ).then(
                                    (value) {
                                      setState(() {});
                                    },
                                  );
                                },
                                child: TaskCardWidget(
                                  title: snapshot.data[index].title,
                                  desc: snapshot.data[index].description,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 24.0,
                right: 0.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Taskpage(
                                task: null,
                              )),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    width: loginWidth,
                    height: 60.0,
                    decoration: BoxDecoration(
                      // gradient: LinearGradient(
                      //     List: [Color(0xFF7349FE), Color(0xFF643FDB)],
                      //     begin: Alignment(0.0, -1.0),
                      //     end: Alignment(0.0, 1.0)),
                      color: Colors.green[600],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text("Add \nProject",
                              textAlign: TextAlign.right,
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                          Spacer(),
                          Image(
                            image: AssetImage(
                              "assets/images/add_icon.png",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
