import 'package:eco_app/models/task.dart';
import 'package:eco_app/models/todo.dart';
import 'package:eco_app/utils/database_helper.dart';
import 'package:eco_app/utils/widgets.dart';
import 'package:flutter/material.dart';

class Taskpage extends StatefulWidget {
  final Task task;

  Taskpage({@required this.task});

  @override
  _TaskpageState createState() => _TaskpageState();
}

class _TaskpageState extends State<Taskpage> {
  DatabaseHelper _dbHelper = DatabaseHelper();

  int _taskId = 0;
  String _taskTitle = "";
  String _taskDescription = "";

  FocusNode _titleFocus;
  FocusNode _descriptionFocus;
  FocusNode _todoFocus;

  bool _contentVisile = false;

  @override
  void initState() {
    if (widget.task != null) {
      // Set visibility to true
      _contentVisile = true;

      _taskTitle = widget.task.title;
      _taskDescription = widget.task.description;
      _taskId = widget.task.id;
    }

    _titleFocus = FocusNode();
    _descriptionFocus = FocusNode();
    _todoFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    _todoFocus.dispose();

    super.dispose();
  }

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
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 24.0,
                      bottom: 6.0,
                    ),
                    child: Row(
                      children: [
                        // InkWell(
                        //   onTap: () {
                        //     Navigator.pop(context);
                        //   },
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(24.0),
                        //     child: IconButton(
                        //       color: Colors.black,
                        //       icon: Icon(Icons.arrow_back_ios),
                        //       onPressed: () => Navigator.pop(context),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 24),
                        ),
                        Expanded(
                          child: TextField(
                            focusNode: _titleFocus,
                            onSubmitted: (value) async {
                              // Check if the field is not empty
                              if (value != "") {
                                // Check if the task is null
                                if (widget.task == null) {
                                  Task _newTask = Task(title: value);
                                  _taskId =
                                      await _dbHelper.insertTask(_newTask);
                                  setState(() {
                                    _contentVisile = true;
                                    _taskTitle = value;
                                  });
                                } else {
                                  await _dbHelper.updateTaskTitle(
                                      _taskId, value);
                                  print("Task Updated");
                                }
                                _descriptionFocus.requestFocus();
                              }
                            },
                            controller: TextEditingController()
                              ..text = _taskTitle,
                            decoration: InputDecoration(
                              hintText: "Enter Project Title",
                              hintStyle: TextStyle(
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                              ),
                              // hintText: "Enter Project Name",

                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: _contentVisile,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: 12.0,
                      ),
                      child: TextField(
                        style: TextStyle(
                          // fontSize: 26.0,
                          // fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                        focusNode: _descriptionFocus,
                        onSubmitted: (value) async {
                          if (value != "") {
                            if (_taskId != 0) {
                              await _dbHelper.updateTaskDescription(
                                  _taskId, value);
                              _taskDescription = value;
                            }
                          }
                          _todoFocus.requestFocus();
                        },
                        controller: TextEditingController()
                          ..text = _taskDescription,
                        decoration: InputDecoration(
                          hintText: "Enter Description for the project..",
                          hintStyle: TextStyle(
                            color: Colors.grey[800],
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 24.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _contentVisile,
                    child: FutureBuilder(
                      initialData: [],
                      future: _dbHelper.getTodo(_taskId),
                      builder: (context, snapshot) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  if (snapshot.data[index].isDone == 0) {
                                    await _dbHelper.updateTodoDone(
                                        snapshot.data[index].id, 1);
                                  } else {
                                    await _dbHelper.updateTodoDone(
                                        snapshot.data[index].id, 0);
                                  }
                                  setState(() {});
                                },
                                child: TodoWidget(
                                  text: snapshot.data[index].title,
                                  isDone: snapshot.data[index].isDone == 0
                                      ? false
                                      : true,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: _contentVisile,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.0,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 20.0,
                            height: 20.0,
                            margin: EdgeInsets.only(
                              right: 12.0,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(6.0),
                                border: Border.all(
                                    color: Colors.green[600], width: 1.5)),
                            child: Image(
                              image: AssetImage('assets/images/check_icon.png'),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              style: TextStyle(
                                color: Colors.grey[800],
                              ),
                              focusNode: _todoFocus,
                              controller: TextEditingController()..text = "",
                              onSubmitted: (value) async {
                                // Check if the field is not empty
                                if (value != "") {
                                  if (_taskId != 0) {
                                    DatabaseHelper _dbHelper = DatabaseHelper();
                                    Todo _newTodo = Todo(
                                      title: value,
                                      isDone: 0,
                                      taskId: _taskId,
                                    );
                                    await _dbHelper.insertTodo(_newTodo);
                                    setState(() {});
                                    _todoFocus.requestFocus();
                                  } else {
                                    print("Task doesn't exist");
                                  }
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Enter Todo item...",
                                hintStyle: TextStyle(
                                  color: Colors.grey[800],
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Visibility(
                visible: _contentVisile,
                child: Positioned(
                  bottom: 24.0,
                  right: 24.0,
                  child: GestureDetector(
                    onTap: () async {
                      if (_taskId != 0) {
                        await _dbHelper.deleteTask(_taskId);
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Image(
                        image: AssetImage(
                          "assets/images/delete_icon.png",
                        ),
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
